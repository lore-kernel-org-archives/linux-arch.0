From: Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 15/16] io_uring: add file registration
Date: Wed, 16 Jan 2019 08:15:16 -0700
Message-ID: <d19dbfae-f424-8987-14a4-66f801f7fa71@kernel.dk>
References: <20190115025531.13985-1-axboe@kernel.dk>
 <20190115025531.13985-16-axboe@kernel.dk>
 <CAK8P3a2oHO-q6Nes3uakjFVcwYOAPHvLMyQW_qQg1_47PfH8Ng@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-aio@kvack.org>
In-Reply-To: <CAK8P3a2oHO-q6Nes3uakjFVcwYOAPHvLMyQW_qQg1_47PfH8Ng@mail.gmail.com>
Content-Language: en-US
Sender: owner-linux-aio@kvack.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>, linux-aio <linux-aio@kvack.org>, linux-block <linux-block@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Christoph Hellwig <hch@lst.de>, Jeff Moyer <jmoyer@redhat.com>, Avi Kivity <avi@scylladb.com>
List-Id: linux-arch.vger.kernel.org

On 1/16/19 3:45 AM, Arnd Bergmann wrote:
> On Tue, Jan 15, 2019 at 3:56 AM Jens Axboe <axboe@kernel.dk> wrote:
> 
>> @@ -132,4 +139,12 @@ struct io_uring_register_buffers {
>>         __u32 nr_iovecs;
>>  };
>>
>> +struct io_uring_register_files {
>> +       union {
>> +               __s32 *fds;
>> +               __u64 pad;
>> +       };
>> +       __u32 nr_fds;
>> +};
> 
> I think you should either remove the pad field here, or pass the pointer
> using a __u64 argument itself. With the current definition, the ioctl
> command code is the same between 32-bit and 64-bit architectures
> (since the length is the same on anything other than x86), but the
> structures are incompatible.

Ah ok, I think I'm starting to follow. Thanks Arnd, that's useful.
I'll make the changes throughout the structs.

> I would also suggest adding an explicit 32-bit pad field at the end
> of the structure, to avoid the implicit padding on non-i386 machines.

That's a good point, I'll make that change, that was an oversight.

-- 
Jens Axboe

--
To unsubscribe, send a message with 'unsubscribe linux-aio' in
the body to majordomo@kvack.org.  For more info on Linux AIO,
see: http://www.kvack.org/aio/
Don't email: <a href=mailto:"aart@kvack.org">aart@kvack.org</a>
