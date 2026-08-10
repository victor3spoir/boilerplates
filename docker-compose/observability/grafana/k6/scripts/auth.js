import http from "k6/http";
import { check } from "k6";

export const options = {
	vus: 100,
	duration: "5m",
};

export default function () {
	const res = http.post(
		"https://api.example.com/login",
		JSON.stringify({
			username: "test",
			password: "password",
		}),
		{
			headers: {
				"Content-Type": "application/json",
			},
		},
	);

	check(res, {
		"status is 200": (r) => r.status === 200,
	});
}