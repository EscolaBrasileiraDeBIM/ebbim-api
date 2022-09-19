<?php
    class ResultService{
        public int $status;
        public ?array $data;
        public ?String $message;

        public function Ok($status, $data){
            $this->status = $status;
            $this->data = $data;
        }

        public function Fail($status, $message){
            $this->status = $status;
            $this->message = $message;
        }

        public function OkNoData($status){
            $this->status = $status;
        }
    }