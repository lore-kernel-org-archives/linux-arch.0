Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:49971 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729216AbeK3Dii (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 29 Nov 2018 22:38:38 -0500
Subject: Re: [for-next][PATCH 00/18] function_graph: Add separate depth
 counter to prevent trace corruption
References: <20181122002801.501220343@goodmis.org>
 <20181128203931.ym2rkya7a6agzzy3@redhat.com>
 <20181128160021.09acd1af@gandalf.local.home>
 <20181128222936.74da7f54@vmware.local.home>
 <20181128232430.425f8b12@vmware.local.home>
 <044db9c0-a937-252f-b9e6-e4060bca3b0d@redhat.com>
 <20181129111708.766f35d6@gandalf.local.home>
From: Joe Lawrence <joe.lawrence@redhat.com>
Message-ID: <11879829-4827-8eda-7cb8-ddcfdc404120@redhat.com>
Date: Thu, 29 Nov 2018 11:32:39 -0500
MIME-Version: 1.0
In-Reply-To: <20181129111708.766f35d6@gandalf.local.home>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, linux-arch@vger.kernel.org, Joel Fernandes <joel@joelfernandes.org>, Masami Hiramatsu <mhiramat@kernel.org>, Josh Poimboeuf <jpoimboe@redhat.com>, Andy Lutomirski <luto@kernel.org>, Frederic Weisbecker <frederic@kernel.org>
Message-ID: <20181129163239.xpi5oUa_hsDndaZeAluiuZYkSw7Y5mFfehQ9CpHQghQ@z>

On 11/29/2018 11:17 AM, Steven Rostedt wrote:
> On Thu, 29 Nov 2018 10:08:55 -0500
> Joe Lawrence <joe.lawrence@redhat.com> wrote:
> 
>> With the "take 2" patch, I only see smp_irq_work_interrupt() graph when
>> the graph_function is in progress..  for example:
> 
> In other words it works :-)
> 
> Can I get a Tested-by from you?
> 

Yup, thanks for fixing!

Tested-by: Joe Lawrence <joe.lawrence@redhat.com>

-- Joe
