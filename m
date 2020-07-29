From: Steven Price <steven.price@arm.com>
Subject: Re: [patch V5 00/15] entry, x86, kvm: Generic entry/exit
 functionality for host and guest
Date: Wed, 29 Jul 2020 14:39:51 +0100
Message-ID: <e0edb228-b7e1-09ae-c41a-b5f4cbf37347@arm.com>
References: <20200722215954.464281930@linutronix.de>
 <878sf8tz51.fsf@nanos.tec.linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <878sf8tz51.fsf@nanos.tec.linutronix.de>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>
Cc: x86@kernel.org, linux-arch@vger.kernel.org, Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Mark Rutland <mark.rutland@arm.com>, Kees Cook <keescook@chromium.org>, Keno Fischer <keno@juliacomputing.com>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, Gabriel Krisman Bertazi <krisman@collabora.com>, Sean Christopherson <sean.j.christopherson@intel.com>
List-Id: linux-arch.vger.kernel.org

On 24/07/2020 21:51, Thomas Gleixner wrote:
> Thomas Gleixner <tglx@linutronix.de> writes:
>> This is the 5th version of generic entry/exit functionality for host and
>> guest.
> 
> I've merged the pile in two steps. Patch 1-5, i.e. the generic code is
> here:
> 
>    git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core/entry
> 
> and merged this branch and patch 6-15 into
> 
>    git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/entry
> 
> core/entry is immutable and any updates, changes go on top. It's meant
> as a base for other architecture developers who want to fiddle with that
> without having to get the x86 mess as well.

Hi Thomas,

Just FYI: I'm going to take a look at arm64 support for this. I know 
Mark previously posted[1] a series moving much of the code to C, so 
hopefully I can build on that and make use of the generic code.

Thanks,

Steve

[1] https://lore.kernel.org/r/20200108185634.1163-1-mark.rutland@arm.com
