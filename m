From: Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH v15 06/23] selftests/vm/pkeys: Typecast the pkey register
Date: Wed, 18 Dec 2019 12:46:50 -0800
Message-ID: <5b6c3f8a-9d2f-2534-c072-89f130ce110f@intel.com>
References: <cover.1576645161.git.sandipan@linux.ibm.com>
 <719ec65756a64cc03e8464a9c6da51c4519d2389.1576645161.git.sandipan@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
In-Reply-To: <719ec65756a64cc03e8464a9c6da51c4519d2389.1576645161.git.sandipan@linux.ibm.com>
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
To: Sandipan Das <sandipan@linux.ibm.com>, shuahkh@osg.samsung.com, linux-kselftest@vger.kernel.org
Cc: linux-arch@vger.kernel.org, fweimer@redhat.com, aneesh.kumar@linux.ibm.com, x86@kernel.org, linuxram@us.ibm.com, mhocko@kernel.org, linux-mm@kvack.org, mingo@redhat.com, msuchanek@suse.de, linuxppc-dev@lists.ozlabs.org, bauerman@linux.ibm.com
List-Id: linux-arch.vger.kernel.org

On 12/17/19 11:51 PM, Sandipan Das wrote:
>  	write_pkey_reg(pkey_reg);
> -	dprintf4("pkey_reg now: %08x\n", read_pkey_reg());
> +	dprintf4("pkey_reg now: "PKEY_REG_FMT"\n", read_pkey_reg());
>  }
>  
>  #define ARRAY_SIZE(x) (sizeof(x) / sizeof(*(x)))
> diff --git a/tools/testing/selftests/vm/pkey-x86.h b/tools/testing/selftests/vm/pkey-x86.h
> index 2f04ade8ca9c..5f40901219d3 100644
> --- a/tools/testing/selftests/vm/pkey-x86.h
> +++ b/tools/testing/selftests/vm/pkey-x86.h
> @@ -46,6 +46,8 @@
>  #define HPAGE_SIZE		(1UL<<21)
>  #define PAGE_SIZE		4096
>  #define MB			(1<<20)
> +#define pkey_reg_t		u32
> +#define PKEY_REG_FMT		"%016x"

How big is the ppc one?

I'd really just rather do %016lx *everywhere* than sprinkle the
PKEY_REG_FMTs around.

BTW, why are you doing a %016lx for a u32?
