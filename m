From: Dave Hansen <dave.hansen@intel.com>
Subject: Re: [RFC v5 12/38] mm: ability to disable execute permission on a key
 at creation
Date: Tue, 11 Jul 2017 11:11:46 -0700
Message-ID: <3bd2ffd4-33ad-ce23-3db1-d1292e69ca9b@intel.com>
References: <1499289735-14220-1-git-send-email-linuxram@us.ibm.com>
 <1499289735-14220-13-git-send-email-linuxram@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1499289735-14220-13-git-send-email-linuxram@us.ibm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Ram Pai <linuxram@us.ibm.com>, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org, linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au, khandual@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com, bsingharora@gmail.com, hbabu@us.ibm.com, arnd@arndb.de, akpm@linux-foundation.org, corbet@lwn.net, mingo@redhat.com
List-Id: linux-arch.vger.kernel.org

On 07/05/2017 02:21 PM, Ram Pai wrote:
> Currently sys_pkey_create() provides the ability to disable read
> and write permission on the key, at  creation. powerpc  has  the
> hardware support to disable execute on a pkey as well.This patch
> enhances the interface to let disable execute  at  key  creation
> time. x86 does  not  allow  this.  Hence the next patch will add
> ability  in  x86  to  return  error  if  PKEY_DISABLE_EXECUTE is
> specified.
> 
> Signed-off-by: Ram Pai <linuxram@us.ibm.com>
> ---
>  include/uapi/asm-generic/mman-common.h |    4 +++-
>  1 files changed, 3 insertions(+), 1 deletions(-)
> 
> diff --git a/include/uapi/asm-generic/mman-common.h b/include/uapi/asm-generic/mman-common.h
> index 8c27db0..bf4fa07 100644
> --- a/include/uapi/asm-generic/mman-common.h
> +++ b/include/uapi/asm-generic/mman-common.h
> @@ -74,7 +74,9 @@
>  
>  #define PKEY_DISABLE_ACCESS	0x1
>  #define PKEY_DISABLE_WRITE	0x2
> +#define PKEY_DISABLE_EXECUTE	0x4
>  #define PKEY_ACCESS_MASK	(PKEY_DISABLE_ACCESS |\
> -				 PKEY_DISABLE_WRITE)
> +				 PKEY_DISABLE_WRITE  |\
> +				 PKEY_DISABLE_EXECUTE)

If you do this, it breaks bisection.  Can you please just do this in one
patch?
