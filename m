From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RFC PATCH v1 04/40] trace/ring_buffer: handle 64bit aligned
 structs
Date: Thu, 01 Nov 2012 15:30:05 -0400
Message-ID: <1351798205.4004.114.camel@gandalf.local.home>
References: <1351700061-7203-1-git-send-email-james.hogan@imgtec.com>
	 <1351700061-7203-5-git-send-email-james.hogan@imgtec.com>
	 <1351706364.4004.87.camel@gandalf.local.home>
	 <CAFbHwiQnEaNXWJg-qB=0WrUqkKP82PrJrrKRRhDfP-34oz7X5A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.122]:14868 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933652Ab2KATaI (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 1 Nov 2012 15:30:08 -0400
In-Reply-To: <CAFbHwiQnEaNXWJg-qB=0WrUqkKP82PrJrrKRRhDfP-34oz7X5A@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Will Newton <will.newton@gmail.com>
Cc: James Hogan <james.hogan@imgtec.com>, linux-arch@vger.kernel.org, Frederic Weisbecker <fweisbec@gmail.com>, Ingo Molnar <mingo@redhat.com>

On Thu, 2012-11-01 at 17:32 +0000, Will Newton wrote:

> > and make sure that the events report correctly your arch (metag). I just
> > want to make sure that it still reads the binary data correctly. I
> > should as the /sys/kernel/debug/tracing/events/header_page should
> > express the difference in the offset of data.
> 
> I just ran trace-cmd on our arch and it appears to work.
> 
> # cat /sys/kernel/debug/tracing/events/header_page
>         field: u64 timestamp;   offset:0;       size:8; signed:0;
>         field: local_t commit;  offset:8;       size:4; signed:1;
>         field: int overwrite;   offset:8;       size:1; signed:1;
>         field: char data;       offset:16;      size:4080;      signed:0;
> 
> Does that look ok?

Yep, it seems fine.

-- Steve
