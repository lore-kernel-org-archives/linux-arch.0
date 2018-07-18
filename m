From: Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH v14 12/22] selftests/vm: pkey register should match shadow
 pkey
Date: Wed, 18 Jul 2018 09:00:11 -0700
Message-ID: <13e29efb-6a75-d6c8-e9a8-9e7495b88e00@intel.com>
References: <1531835365-32387-1-git-send-email-linuxram@us.ibm.com>
 <1531835365-32387-13-git-send-email-linuxram@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
In-Reply-To: <1531835365-32387-13-git-send-email-linuxram@us.ibm.com>
Content-Language: en-US
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Errors-To: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
To: Ram Pai <linuxram@us.ibm.com>, shuahkh@osg.samsung.com, linux-kselftest@vger.kernel.org
Cc: linux-arch@vger.kernel.org, fweimer@redhat.com, x86@kernel.org, mhocko@kernel.org, linux-mm@kvack.org, mingo@redhat.com, aneesh.kumar@linux.vnet.ibm.com, bauerman@linux.vnet.ibm.com, msuchanek@suse.de, linuxppc-dev@lists.ozlabs.org
List-Id: linux-arch.vger.kernel.org

On 07/17/2018 06:49 AM, Ram Pai wrote:
> expected_pkey_fault() is comparing the contents of pkey
> register with 0. This may not be true all the time. There
> could be bits set by default by the architecture
> which can never be changed. Hence compare the value against
> shadow pkey register, which is supposed to track the bits
> accurately all throughout

This is getting dangerously close to full sentences that actually
describe the patch.  You forgot a period, but much this is a substantial
improvement over earlier parts of the series.  Thanks for writing this,
seriously.

> cc: Dave Hansen <dave.hansen@intel.com>
> cc: Florian Weimer <fweimer@redhat.com>
> Signed-off-by: Ram Pai <linuxram@us.ibm.com>
> ---
>  tools/testing/selftests/vm/protection_keys.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/vm/protection_keys.c b/tools/testing/selftests/vm/protection_keys.c
> index 2e448e0..f50cce8 100644
> --- a/tools/testing/selftests/vm/protection_keys.c
> +++ b/tools/testing/selftests/vm/protection_keys.c
> @@ -913,10 +913,10 @@ void expected_pkey_fault(int pkey)
>  		pkey_assert(last_si_pkey == pkey);
>  
>  	/*
> -	 * The signal handler shold have cleared out PKEY register to let the
> +	 * The signal handler should have cleared out pkey-register to let the
>  	 * test program continue.  We now have to restore it.
>  	 */

... while I appreciate the spelling corrections, and I would totally ack
a patch that fixed them in one fell swoop, could we please segregate the
random spelling corrections from code fixes unless you touch those lines
otherwise?

> -	if (__read_pkey_reg() != 0)
> +	if (__read_pkey_reg() != shadow_pkey_reg)
>  		pkey_assert(0);
>  
>  	__write_pkey_reg(shadow_pkey_reg);

I know this is a one-line change, but I don't fully understand it.

On x86, if we take a pkey fault, we clear PKRU entirely (via the
on-stack XSAVE state that is restored at sigreturn) which allows the
faulting instruction to resume and execute normally.  That's what this
check is looking for: Did the signal handler clear PKRU?

Now, you're saying that powerpc might not clear it.  That makes sense.

While PKRU's state here is obvious, it isn't patently obvious to me what
shadow_pkey_reg's state is.  In fact, looking at it, I don't see the
signal handler manipulating the shadow.  So, how can this patch work?
