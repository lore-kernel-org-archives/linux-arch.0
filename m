Return-Path: <alexandre.chartre@oracle.com>
Subject: Re: [patch V2 02/17] x86/entry/64: Remove pointless jump in
 paranoid_exit
References: <20191023122705.198339581@linutronix.de>
 <20191023123117.779277679@linutronix.de>
From: Alexandre Chartre <alexandre.chartre@oracle.com>
Message-ID: <10e378e2-d9dc-e8dd-fe62-7427b061decf@oracle.com>
Date: Wed, 6 Nov 2019 16:29:25 +0100
MIME-Version: 1.0
In-Reply-To: <20191023123117.779277679@linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>
Cc: x86@kernel.org, Peter Zijlstra <peterz@infradead.org>, Andy Lutomirski <luto@kernel.org>, Will Deacon <will@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-arch@vger.kernel.org, Mike Rapoport <rppt@linux.ibm.com>, Josh Poimboeuf <jpoimboe@redhat.com>, Miroslav Benes <mbenes@suse.cz>
List-ID: <linux-arch.vger.kernel.org>
Message-ID: <20191106152925.gSSnPCsD2oc7wJLK1_Tyu1-06R2rn3C2SezWvgpRENk@z>


On 10/23/19 2:27 PM, Thomas Gleixner wrote:
> Jump directly to restore_regs_and_return_to_kernel instead of making
> a pointless extra jump through .Lparanoid_exit_restore
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>   arch/x86/entry/entry_64.S |    3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 

Reviewed-by: Alexandre Chartre <alexandre.chartre@oracle.com>

alex.
