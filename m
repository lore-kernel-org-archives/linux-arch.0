From: Russell King - ARM Linux <linux@armlinux.org.uk>
Subject: Re: [PATCH 07/11] signal/arm64: Document conflicts with SI_USER and
 SIGFPE, SIGTRAP, SIGBUS
Date: Wed, 17 Jan 2018 17:14:25 +0000
Message-ID: <20180117171425.GQ17719@n2100.armlinux.org.uk>
References: <87373b6ghs.fsf@xmission.com>
 <20180112005940.23279-7-ebiederm@xmission.com>
 <20180115163028.GU22781@e103592.cambridge.arm.com>
 <87h8rnox3c.fsf@xmission.com>
 <20180116172407.GA22781@e103592.cambridge.arm.com>
 <871sipl9p9.fsf@xmission.com>
 <20180117115708.GM17719@n2100.armlinux.org.uk>
 <20180117121505.GD22781@e103592.cambridge.arm.com>
 <20180117123752.GN17719@n2100.armlinux.org.uk>
 <87y3kwh1t5.fsf@xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <87y3kwh1t5.fsf@xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Dave Martin <Dave.Martin@arm.com>, linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Nicolas Pitre <nico@linaro.org>, Tony Lindgren <tony@atomide.com>, Catalin Marinas <catalin.marinas@arm.com>, Tyler Baicar <tbaicar@codeaurora.org>, Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>, James Morse <james.morse@arm.com>, Al Viro <viro@zeniv.linux.org.uk>, Olof Johansson <olof@lixom.net>, Santosh Shilimkar <santosh.shilimkar@ti.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-arch.vger.kernel.org

On Wed, Jan 17, 2018 at 10:45:10AM -0600, Eric W. Biederman wrote:
> Russell King - ARM Linux <linux@armlinux.org.uk> writes:
> >From your description there still seems to be an association with an
> instruction so I don't know if I would really call the signal
> asynchronous.  It sounds like the exception is delayed and not
> asynchronous.

Traps can only be passed from ARM coprocessors by a coprocessor refusing
to execute an instruction.  That's what happens in this case - the VFP
gets offered an instruction to execute.  It accepts it, and the CPU
continues, leaving the VFP to execute its instruction independently.  If
this instruction generates an error, then nothing happens at this point.

That error remains pending until the CPU offers the coprocessor the next
VFP instruction, which it refuses.  That causes an undefined instruction
exception, and we trap into the kernel VFP code which reads the VFP
status and works out what needs to be done.

What this means is that if you execute a VFP instruction, wait 10 minutes
and then execute another VFP instruction, if the first VFP instruction
raised an exception, you'll get to hear about it 10 minutes later.

You can use whatever weasel words you want to describe that situation,
my choice is "asynchronous", your choice is "delayed".  However, it is
clearly not "synchronous", and arguing that we should report something
synchronously that is not reported to _us_ synchronously (where
synchronous means "at the same time") is IMHO daft.

So, let's take an example:

	installs SIGFPE handler
	..fp instructions.. one of which raises an exception
	returns to main loop
	main loop blocks all signals while it sets stuff up
	calls ppoll()

In the synchronous SIGFPE delivery case, the SIGFPE handler will be
called when the exception is generated in the FP code, and delivered
at that time.  The fact that the main loop blocks all signals happens
later, so the users handler gets called as one expects.

In the VFP case, however, the FP instructions towards the end may not
end up causing the exception to be signalled until sometime later,
and as I've already explained, that may be the result of a C library
function accessing the VFP registers.  This could well end up trying
to deliver the SIGFPE while signals are blocked, and we get
drastically different behaviour if force_sig_info() is used.

In the VFP case, if force_sig_info() is used, the program gets killed
at this point.  In the non-VFP case, the program's signal handler was
called.

Using send_sig_info() results in the already delayed or asynchronous
signal being held off until ppoll() drops the blocking, at which point
the signal is delivered, the program handles it in its handler, and
the program continues to run.

So
1. non-VFP case, program doesn't get killed but gets the opportunity
   to handle the signal.
2. VFP case with send_sig_info, program doesn't get killed but gets
   the opportunity to handle the signal.
3. VFP case with force_sig_info, the program gets killed and dumps
   core.

Which one of these results in a big change of behaviour in your
opinion?

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
