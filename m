From: Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH RFC 2/5] x86/speculation: Add support for
 'cpu_spec_mitigations=' cmdline options
Date: Fri, 5 Apr 2019 08:18:09 -0700
Message-ID: <5ccc7515-33e6-b726-833e-9553ab0f4c6a@infradead.org>
References: <cover.1554396090.git.jpoimboe@redhat.com>
 <78c63cb08f36f55407f534d49cc2543079e44dbb.1554396090.git.jpoimboe@redhat.com>
 <20190405135712.GF23348@zn.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190405135712.GF23348@zn.tnic>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Borislav Petkov <bp@alien8.de>, Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, Paul Mackerras <paulus@samba.org>, "H . Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@kernel.org>, Andrea Arcangeli <aarcange@redhat.com>, linux-s390@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>, x86@kernel.org, Will Deacon <will.deacon@arm.com>, Linus Torvalds <torvalds@linux-foundation.org>, Catalin Marinas <catalin.marinas@arm.com>, Waiman Long <longman@redhat.com>, linux-arch@vger.kernel.org, Jon Masters <jcm@redhat.com>, Jiri Kosina <jikos@kernel.org>, Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, Tyler Hicks <tyhicks@canonical.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>l
List-Id: linux-arch.vger.kernel.org

On 4/5/19 6:57 AM, Borislav Petkov wrote:
> On Thu, Apr 04, 2019 at 11:44:12AM -0500, Josh Poimboeuf wrote:
>> Configure x86 runtime CPU speculation bug mitigations in accordance with
>> the 'cpu_spec_mitigations=' cmdline options.  This affects Meltdown,
>> Spectre v2, Speculative Store Bypass, and L1TF.
>>
>> The default behavior is unchanged.
>>
>> Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
>> ---
>>  .../admin-guide/kernel-parameters.txt         | 15 +++++++++
>>  arch/x86/include/asm/processor.h              |  1 +
>>  arch/x86/kernel/cpu/bugs.c                    | 32 ++++++++++++++++---
>>  arch/x86/kvm/vmx/vmx.c                        |  2 ++
>>  arch/x86/mm/pti.c                             |  4 ++-
>>  5 files changed, 49 insertions(+), 5 deletions(-)
>>
>> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
>> index ac42e510bd6e..29dc03971630 100644
>> --- a/Documentation/admin-guide/kernel-parameters.txt
>> +++ b/Documentation/admin-guide/kernel-parameters.txt
>> @@ -2552,6 +2552,11 @@
>>  
>>  			off
>>  				Disable all speculative CPU mitigations.
>> +				Equivalent to: nopti [x86]
>> +					       nospectre_v2 [x86]
>> +					       spectre_v2_user=off [x86]
>> +					       spec_store_bypass_disable=off [x86]
>> +					       l1tf=off [x86]
>>  
>>  			auto (default)
>>  				Mitigate all speculative CPU vulnerabilities,
>> @@ -2560,12 +2565,22 @@
>>  				surprised by SMT getting disabled across kernel
>>  				upgrades, or who have other ways of avoiding
>>  				SMT-based attacks.
>> +				Equivalent to: pti=auto [x86]
>> +					       spectre_v2=auto [x86]
>> +					       spectre_v2_user=auto [x86]
>> +					       spec_store_bypass_disable=auto [x86]
>> +					       l1tf=flush [x86]
>>  
>>  			auto,nosmt
>>  				Mitigate all speculative CPU vulnerabilities,
>>  				disabling SMT if needed.  This is for users who
>>  				always want to be fully mitigated, even if it
>>  				means losing SMT.
>> +				Equivalent to: pti=auto [x86]
>> +					       spectre_v2=auto [x86]
>> +					       spectre_v2_user=auto [x86]
>> +					       spec_store_bypass_disable=auto [x86]
>> +					       l1tf=flush,nosmt [x86]
>>  
>>  	mminit_loglevel=
>>  			[KNL] When CONFIG_DEBUG_MEMORY_INIT is set, this
> 
> Yap, those sets look ok.

nit:  s/x86/X86/g
according to Documentation/admin-guide/kernel-parameters.rst


-- 
~Randy
