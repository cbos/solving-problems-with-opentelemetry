import http from 'k6/http';
import { sleep } from 'k6';
export const options = {
    vus: 2,
    duration: '360s',
};
export default function () {
    http.get('http://localhost:8081/');
    sleep(100);
    http.get('http://localhost:8082/');
}