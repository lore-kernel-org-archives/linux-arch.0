Return-Path: <alexandre.chartre@oracle.com>
Subject: Re: [patch V2 01/17] x86/entry/32: Remove unused resume_userspace
 label
References: <20191023122705.198339581@linutronix.de>
 <20191023123117.686514045@linutronix.de>
From: Alexandre Chartre <alexandre.chartre@oracle.com>
Message-ID: <92929be8-d936-75b9-80c0-368d7f33162a@oracle.com>
Date: Wed, 6 Nov 2019 16:26:39 +0100
MIME-Version: 1.0
In-Reply-To: <20191023123117.686514045@linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>
Cc: x86@kernel.org, Peter Zijlstra <peterz@infradead.org>, Andy Lutomirski <luto@kernel.org>, Will Deacon <will@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-arch@vger.kernel.org, Mike Rapoport <rppt@linux.ibm.com>, Josh Poimboeuf <jpoimboe@redhat.com>, Miroslav Benes <mbenes@suse.cz>
List-ID: <linux-arch.vger.kernel.org>
Message-ID: <20191106152639.Wgw_VQVYOnRj_VgoX4GMcdQo0HxRifvKeumIXgsSjNw@z>


On 10/23/19 2:27 PM, Thomas Gleixner wrote:
> The C reimplementation of SYSENTER left that unused ENTRY() label
> around. Remove it.
> 
> Fixes: 5f310f739b4c ("x86/entry/32: Re-implement SYSENTER using the new C path")
> Originally-by: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>   arch/x86/entry/entry_32.S |    1 -
>   1 file changed, 1 deletion(-)
> 

Reviewed-by: Alexandre Chartre <alexandre.chartre@oracle.com>

alex.
