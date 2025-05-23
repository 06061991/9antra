import { HttpClient } from "@angular/common/http";
import { Injectable } from "@angular/core";
import { message } from "src/app/Models/message";
import {environement} from "../../../environement/environement.dev";

@Injectable({
  providedIn: 'root',
})
export class ForumService {
  constructor(private http: HttpClient) {}

  getForum(page:any,per_page:any,search:any){
    return this.http.get(`${environement.GATEWAY_API_URL}/api/forum/getPosts?page=${page}&size=${per_page}&search=${search}`)
  }

  send(forum: message,user_id:any){
    return this.http.post(`${environement.GATEWAY_API_URL}/api/forum/createPost?user_id=${user_id}`,forum)
  }

  sendAnswer(id:any,forum_id:any,forum: message){
    return this.http.post(`${environement.GATEWAY_API_URL}/api/forum/response/create?id=${id}&forum_id=${forum_id}`,forum)
  }

  deleteMessage(id:any,forum:null){
    return this.http.put(`${environement.GATEWAY_API_URL}/api/forum/deleteMessage?id=${id}`,forum)
  }

  getForumById(id:any){
    return this.http.get(`${environement.GATEWAY_API_URL}/api/forum/getForumById?id=${id}`);
  }
}
