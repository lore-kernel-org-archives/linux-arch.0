From: Namhyung Kim <namhyung@kernel.org>
Subject: Re: [RFC/PATCH v2] ftrace: Reduce size of function graph entries
Date: Wed, 29 Jun 2016 10:32:34 +0900
Message-ID: <20160629013234.GA1628@sejong>
References: <1467091840-4625-1-git-send-email-namhyung@kernel.org>
 <20160628193200.71629fc5@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from LGEAMRELO11.lge.com ([156.147.23.51]:46433 "EHLO
	lgeamrelo11.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752509AbcF2Bcj (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 28 Jun 2016 21:32:39 -0400
In-Reply-To: <20160628193200.71629fc5@gandalf.local.home>
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org

On Tue, Jun 28, 2016 at 07:32:00PM -0400, Steven Rostedt wrote:
> On Tue, 28 Jun 2016 14:30:40 +0900
> Namhyung Kim <namhyung@kernel.org> wrote:
> 
> > Currently ftrace_graph_ent{,_entry} and ftrace_graph_ret{,_entry} struct
> > can have padding bytes at the end due to alignment in 64-bit data type.
> > As these data are recorded so frequently, those paddings waste
> > non-negligible space.  As some archs can have efficient unaligned
> > accesses, reducing the alignment can save ~10% of data size:
> > 
> >   ftrace_graph_ent_entry:  24 -> 20
> >   ftrace_graph_ret_entry:  48 -> 44
> > 
> > Also I moved the 'overrun' field in struct ftrace_graph_ret to minimize
> > the padding.  I think the FTRACE_ALIGNMENT still needs to have proper
> > alignment (even if ring buffer handles the alignment after all) since
> > the ftrace_graph_ent/ret struct is located on stack before copying to
> > the ring buffer.
> 
> I don't know. I mean it doesn't hurt to keep the alignment, but I'm
> still thinking that it's overkill. All elements will start on their
> proper alignment anyway.
> 
> Think about it, we have:
> 
> For 32bit:
> 
>   struct ftrace_graph_ret {
>   	unsigned long func; /* Current function */
> 
> is at 0-3
> 
>   	/* Number of functions that overran the depth limit for current task */
>   	unsigned long overrun;
> 
> is at 4-7
> 
> 	unsigned long long calltime;
> 
> is at 8-15
> 
> 	unsigned long long rettime;
> is at 16-23
> 
>   	int depth;
> 
> is at 24-28
> 
> And for 64bit:
> 
>   struct ftrace_graph_ret {
>   	unsigned long func; /* Current function */
> 
> is at 0-7
> 
>   	/* Number of functions that overran the depth limit for current task */
>   	unsigned long overrun;
> 
> is at 8-15
> 
> 	unsigned long long calltime;
> 
> is at 16-23
> 
> 	unsigned long long rettime;
> 
> is at 24-31
> 
>   	int depth;
> 
> is at 32-37
> 
> For a total of 38 bytes. I'm betting that without the packed, the 4
> extra bytes will always be at the end.

Woundn't it be 36 or 40 bytes? :)

> 
> If the compiler places it incorrectly without any attribute, it will
> fail to read the long long if the arch requires 64 bits to be 8 bytes
> aligned. The alignment is meaningless here. All we need is "packed" and
> be done with it. It's only going to truncate the 4 bytes at the end of
> the structure if that.

I agree that in-struct alignment preserved without the 'aligned'
attribute but I'm not sure whether it's guaranteed that the *start*
address of the struct is still in proper alignment boundary.

IOW the struct ftrace_graph_ret should be placed at 8-byte boundary in order
to keep alignment of struct members.  Is it guaranteed after applying
'packed'?

Thanks,
Namhyung
