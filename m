From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: Re: SYSV IPC broken for no-legacy syscall kernels (was Re: [RFC PATCH
 v1 26/31] ARC: Build system: Makefiles, Kconfig, Linker script)
Date: Mon, 11 Mar 2013 19:18:55 +0530
Message-ID: <513DE0C7.9030304@synopsys.com>
References: <1352281674-2186-1-git-send-email-vgupta@synopsys.com> <513DD464.2060008@synopsys.com> <513DD6FB.4000400@imgtec.com> <201303111330.15589.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <201303111330.15589.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: James Hogan <james.hogan@imgtec.com>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Markos <markos.chandras@imgtec.com>
List-Id: linux-arch.vger.kernel.org

Hi Arnd,

On Monday 11 March 2013 07:00 PM, Arnd Bergmann wrote:
> On Monday 11 March 2013, James Hogan wrote:
>>> /*
>>>  * Version flags for semctl, msgctl, and shmctl commands
>>>  * These are passed as bitflags or-ed with the actual command
>>>  */
>>> #define IPC_OLD 0    /* Old version (no 32-bit UID support on many
>>>                architectures) */
>>> #define IPC_64  0x0100  /* New version (support 32-bit UIDs, bigger
>>>                message sizes, etc. */
>>>
>>> So someone with more ABI wisdom needs to suggest what is the right approach.
>> Agreed.
>>
>> Note that in uClibc, 64bit arches (excl alpha/mips for some reason) were
>> already defining __IPC_64 as 0, so there's some precedent for it working
>> the way it does.
> Yes, there is no reason to need the distinction. If LTP is checking for
> IPC_OLD compatibility on anything but really old architectures, that is
> a bug in LTP, or possibly in the libc.
>
> 	Arnd

I'm sorrry - I don't quite understand what you mean.

The question is what should the msgctl(2) ABI be w.r.t. @cmd arg. Does it need to
be of type 0x01NN  (i.e. IPC_64 ORed) or should it be be 0xNN. If it's 0x01NN,
then ARCH_WANT_IPC_PARSE_VERSION is needed in Kconfig, otherwise, I need to fix
uClibc.

The reason for confusion seems to be a comment in existing uapi/linux/ipc.h which
seems to suggest that IPC_OLD is 0 and IPC_64 is newer version.

Thx,
-Vineet
