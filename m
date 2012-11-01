From: Will Newton <will.newton@gmail.com>
Subject: Re: [RFC PATCH v1 04/40] trace/ring_buffer: handle 64bit aligned structs
Date: Thu, 1 Nov 2012 17:32:15 +0000
Message-ID: <CAFbHwiQnEaNXWJg-qB=0WrUqkKP82PrJrrKRRhDfP-34oz7X5A@mail.gmail.com>
References: <1351700061-7203-1-git-send-email-james.hogan@imgtec.com>
	<1351700061-7203-5-git-send-email-james.hogan@imgtec.com>
	<1351706364.4004.87.camel@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-la0-f46.google.com ([209.85.215.46]:59018 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753415Ab2KARcR (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 1 Nov 2012 13:32:17 -0400
Received: by mail-la0-f46.google.com with SMTP id h6so2027540lag.19
        for <linux-arch@vger.kernel.org>; Thu, 01 Nov 2012 10:32:15 -0700 (PDT)
In-Reply-To: <1351706364.4004.87.camel@gandalf.local.home>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: James Hogan <james.hogan@imgtec.com>, linux-arch@vger.kernel.org, Frederic Weisbecker <fweisbec@gmail.com>, Ingo Molnar <mingo@redhat.com>

On Wed, Oct 31, 2012 at 5:59 PM, Steven Rostedt <rostedt@goodmis.org> wrote:
> On Wed, 2012-10-31 at 16:13 +0000, James Hogan wrote:
>> Some 32 bit architectures have 64 bit struct alignment (for example
>> metag which has 64 bit read/write instructions). These require 8 byte
>> alignment of event data too, so use CONFIG_HAVE_64BIT_ALIGNED_STRUCT
>> instead of CONFIG_64BIT to decide alignment, and align
>> buffer_data_page::data accordingly.
>
> Can you test if trace-cmd still reads this correctly.
>
> git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/trace-cmd.git
>
> Run a simple:
>
>  trace-cmd record -e all sleep 2
>  trace-cmd report
>
> and make sure that the events report correctly your arch (metag). I just
> want to make sure that it still reads the binary data correctly. I
> should as the /sys/kernel/debug/tracing/events/header_page should
> express the difference in the offset of data.

I just ran trace-cmd on our arch and it appears to work.

# cat /sys/kernel/debug/tracing/events/header_page
        field: u64 timestamp;   offset:0;       size:8; signed:0;
        field: local_t commit;  offset:8;       size:4; signed:1;
        field: int overwrite;   offset:8;       size:1; signed:1;
        field: char data;       offset:16;      size:4080;      signed:0;

Does that look ok?
