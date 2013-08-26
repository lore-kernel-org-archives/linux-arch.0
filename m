From: Christoph Lameter <cl@linux.com>
Subject: Re: [guv 00/16] [RFC] percpu: Replace __get_cpu_var uses throughout
 the kernel
Date: Mon, 26 Aug 2013 15:21:56 +0000
Message-ID: <00000140bb37931e-fbfdfad2-8241-40cc-b053-7c53d54a9728-000000@email.amazonses.com>
References: <00000140ac8debd6-6f9e64f9-1107-4336-91ef-77cdf764b96a-000000@email.amazonses.com> <20130823200514.GA11391@mtj.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20130823200514.GA11391@mtj.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: akpm@linuxfoundation.org, linux-arch@vger.kernel.org, Steven Rostedt <srostedt@redhat.com>, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Fri, 23 Aug 2013, Tejun Heo wrote:

> * It would be a lot easier to route the patches if each had cc's to
>   the maintainers of the affected subsystems.

So the drivers patch needs to CC all driver maintainers?

There must be some easier way to get this done.

> * Dunno what's the convention around conccinelle scripts but do we
>   need to keep them around if the accessor being converted gets
>   removed at the end of the series?
>
> How do you want to route the patches?  I'm gonna apply the second
> patch which updates __verify_pcpu_ptr() to the percpu tree right away
> and push it to Linus early during the merge window so that pushing
> other patches through different trees from there on isn't too painful.

Not sure how to do this. Thats why its an RFC. I cced Andrew because he
usually knows how to deal with massive patches like this.
