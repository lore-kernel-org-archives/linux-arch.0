From: Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH v14 09/22] selftests/vm: fixed bugs in pkey_disable_clear()
Date: Wed, 18 Jul 2018 08:43:55 -0700
Message-ID: <a59b8787-f9bb-2fc7-c1b4-a5fab5d53647@intel.com>
References: <1531835365-32387-1-git-send-email-linuxram@us.ibm.com>
 <1531835365-32387-10-git-send-email-linuxram@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
In-Reply-To: <1531835365-32387-10-git-send-email-linuxram@us.ibm.com>
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
> instead of clearing the bits, pkey_disable_clear() was setting
> the bits. Fixed it.

Again, I know these are just selftests, but I'm seeing a real lack of
attention to detail with these.  Please at least go to the trouble of
writing actual changelogs with full sentences and actual capitalization.
 I think it's the least you can do if I'm going to spend time reviewing
these.

I'll go one better.  Can you just use this as a changelog?

	pkey_disable_clear() does not work.  Instead of clearing bits,
	it sets them, probably because it originated as a copy-and-paste
	of pkey_disable_set().

	This has been dead code up to now because the only callers are
	pkey_access/write_allow() and _those_ are currently unused.

> Also fixed a wrong assertion in that function. When bits are
> cleared, the resulting bit value will be less than the original.
> 
> This hasn't been a problem so far because this code isn't currently
> used.
> 
> cc: Dave Hansen <dave.hansen@intel.com>
> cc: Florian Weimer <fweimer@redhat.com>
> Signed-off-by: Ram Pai <linuxram@us.ibm.com>
> ---
>  tools/testing/selftests/vm/protection_keys.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/vm/protection_keys.c b/tools/testing/selftests/vm/protection_keys.c
> index 2dd94c3..8fa4f74 100644
> --- a/tools/testing/selftests/vm/protection_keys.c
> +++ b/tools/testing/selftests/vm/protection_keys.c
> @@ -433,7 +433,7 @@ void pkey_disable_clear(int pkey, int flags)
>  			pkey, pkey, pkey_rights);
>  	pkey_assert(pkey_rights >= 0);
>  
> -	pkey_rights |= flags;
> +	pkey_rights &= ~flags;
>
>  	ret = hw_pkey_set(pkey, pkey_rights, 0);
>  	shadow_pkey_reg &= clear_pkey_flags(pkey, flags);
> @@ -446,7 +446,7 @@ void pkey_disable_clear(int pkey, int flags)
>  	dprintf1("%s(%d) pkey_reg: 0x"PKEY_REG_FMT"\n", __func__,
>  			pkey, read_pkey_reg());

If you add a better changelog:

Acked-by: Dave Hansen <dave.hansen@intel.com>

>  	if (flags)
> -		assert(read_pkey_reg() > orig_pkey_reg);
> +		assert(read_pkey_reg() <= orig_pkey_reg);
>  }

This really is an orthogonal change that would have been better placed
with the other patch that did the exact same thing.  But I'd be OK with
it here, as long as it has an actual comment.
