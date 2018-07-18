From: Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH v14 08/22] selftests/vm: fix the wrong assert in
 pkey_disable_set()
Date: Wed, 18 Jul 2018 08:36:50 -0700
Message-ID: <b8ace761-2140-afce-a1d4-fc2a27c8fd9e@intel.com>
References: <1531835365-32387-1-git-send-email-linuxram@us.ibm.com>
 <1531835365-32387-9-git-send-email-linuxram@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
In-Reply-To: <1531835365-32387-9-git-send-email-linuxram@us.ibm.com>
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
> If the flag is 0, no bits will be set. Hence we cant expect
> the resulting bitmap to have a higher value than what it
> was earlier.
...
> --- a/tools/testing/selftests/vm/protection_keys.c
> +++ b/tools/testing/selftests/vm/protection_keys.c
> @@ -415,7 +415,7 @@ void pkey_disable_set(int pkey, int flags)
>  	dprintf1("%s(%d) pkey_reg: 0x"PKEY_REG_FMT"\n",
>  		__func__, pkey, read_pkey_reg());
>  	if (flags)
> -		pkey_assert(read_pkey_reg() > orig_pkey_reg);
> +		pkey_assert(read_pkey_reg() >= orig_pkey_reg);
>  	dprintf1("END<---%s(%d, 0x%x)\n", __func__,
>  		pkey, flags);
>  }

I know these are just selftests, but this change makes zero sense
without the context from how powerpc works.  It's also totally
non-obvious from the patch itself what is going on, even though I
specifically called this out in a previous review.

Please add a comment here that either specifically calls out powerpc or
talks about "an architecture that does this ..."
