From: James Hogan <james.hogan@imgtec.com>
Subject: Re: [PATCH v3 39/44] metag: ftrace support
Date: Thu, 10 Jan 2013 16:13:17 +0000
Message-ID: <50EEE89D.1040405@imgtec.com>
References: <1357831872-29451-1-git-send-email-james.hogan@imgtec.com>  <1357831872-29451-40-git-send-email-james.hogan@imgtec.com> <1357833597.5141.5.camel@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from multi.imgtec.com ([194.200.65.239]:54475 "EHLO multi.imgtec.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752071Ab3AJQOd (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 10 Jan 2013 11:14:33 -0500
In-Reply-To: <1357833597.5141.5.camel@gandalf.local.home>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Frederic Weisbecker <fweisbec@gmail.com>, Ingo Molnar <mingo@redhat.com>

Hi Steven,

On 10/01/13 15:59, Steven Rostedt wrote:
> On Thu, 2013-01-10 at 15:31 +0000, James Hogan wrote:
>> +#include <linux/ftrace.h>
>> +#include <linux/io.h>
>> +#include <linux/uaccess.h>
>> +#include <linux/ftrace.h>
> 
> duplicate <linux/ftrace.h>

Thanks, I'll fix.

> The rest looks good.

Thanks for reviewing

Cheers
James
