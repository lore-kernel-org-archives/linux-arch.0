From: Dave Hansen <dave@sr71.net>
Subject: Re: [PATCH] kconfig: consolidate arch-specific seccomp options
Date: Thu, 30 Jan 2014 08:48:39 -0800
Message-ID: <52EA8267.4020107@sr71.net>
References: <20140129191011.8FB63DFA@viggo.jf.intel.com> <20140130085551.GB2024@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-security-module-owner@vger.kernel.org>
In-Reply-To: <20140130085551.GB2024@gmail.com>
Sender: linux-security-module-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, linux-security-module@vger.kernel.org, linux-arch@vger.kernel.org, sfr@canb.auug.org.au, zohar@linux.vnet.ibm.com, linux@arm.linux.org.uk, monstr@monstr.eu, ralf@linux-mips.org, benh@kernel.crashing.org, paulus@samba.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, lethal@linux-sh.org, x86@kernel.org, james.l.morris@oracle.com
List-Id: linux-arch.vger.kernel.org

On 01/30/2014 12:55 AM, Ingo Molnar wrote:
>> > +	  This kernel feature is useful for number crunching applications
>> > +	  that may need to compute untrusted bytecode during their
>> > +	  execution. By using pipes or other transports made available to
> I'd change and simplify the first sentence to:
> 
>> > +	  This kernel feature is useful to sandbox runtimes that need
>> > +	  to execute untrusted machine code.
> Seccomp isn't primarily about number crunching anymore, and it's 
> definitely not about 'bytecode' in the classical sense either.

I'll change that if I need to send it again.  Otherwise, I'll leave it
to the folks who actually know something about the feature, which isn't me.

