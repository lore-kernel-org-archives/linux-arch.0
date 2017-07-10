From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Subject: Re: [RFC v5 38/38] Documentation: PowerPC specific updates to memory
 protection keys
Date: Mon, 10 Jul 2017 08:37:04 +0530
Message-ID: <d94ab2c1-8be5-f618-6f42-cac2813059a5@linux.vnet.ibm.com>
References: <1499289735-14220-1-git-send-email-linuxram@us.ibm.com>
 <1499289735-14220-39-git-send-email-linuxram@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1499289735-14220-39-git-send-email-linuxram@us.ibm.com>
Sender: linux-doc-owner@vger.kernel.org
To: Ram Pai <linuxram@us.ibm.com>, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org, linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au, khandual@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com, bsingharora@gmail.com, dave.hansen@intel.com, hbabu@us.ibm.com, arnd@arndb.de, akpm@linux-foundation.org, corbet@lwn.net, mingo@redhat.com
List-Id: linux-arch.vger.kernel.org

On 07/06/2017 02:52 AM, Ram Pai wrote:
> Add documentation updates that capture PowerPC specific changes.
> 
> Signed-off-by: Ram Pai <linuxram@us.ibm.com>
> ---
>  Documentation/vm/protection-keys.txt |   85 ++++++++++++++++++++++++++--------
>  1 files changed, 65 insertions(+), 20 deletions(-)
> 
> diff --git a/Documentation/vm/protection-keys.txt b/Documentation/vm/protection-keys.txt
> index b643045..d50b6ab 100644
> --- a/Documentation/vm/protection-keys.txt
> +++ b/Documentation/vm/protection-keys.txt
> @@ -1,21 +1,46 @@
> -Memory Protection Keys for Userspace (PKU aka PKEYs) is a CPU feature
> -which will be found on future Intel CPUs.
> +Memory Protection Keys for Userspace (PKU aka PKEYs) is a CPU feature found in
> +new generation of intel CPUs and on PowerPC 7 and higher CPUs.
>  
>  Memory Protection Keys provides a mechanism for enforcing page-based
> -protections, but without requiring modification of the page tables
> -when an application changes protection domains.  It works by
> -dedicating 4 previously ignored bits in each page table entry to a
> -"protection key", giving 16 possible keys.
> -
> -There is also a new user-accessible register (PKRU) with two separate
> -bits (Access Disable and Write Disable) for each key.  Being a CPU
> -register, PKRU is inherently thread-local, potentially giving each
> -thread a different set of protections from every other thread.
> -
> -There are two new instructions (RDPKRU/WRPKRU) for reading and writing
> -to the new register.  The feature is only available in 64-bit mode,
> -even though there is theoretically space in the PAE PTEs.  These
> -permissions are enforced on data access only and have no effect on
> +protections, but without requiring modification of the page tables when an
> +application changes protection domains.
> +
> +
> +On Intel:
> +
> +	It works by dedicating 4 previously ignored bits in each page table
> +	entry to a "protection key", giving 16 possible keys.
> +
> +	There is also a new user-accessible register (PKRU) with two separate
> +	bits (Access Disable and Write Disable) for each key.  Being a CPU
> +	register, PKRU is inherently thread-local, potentially giving each
> +	thread a different set of protections from every other thread.
> +
> +	There are two new instructions (RDPKRU/WRPKRU) for reading and writing
> +	to the new register.  The feature is only available in 64-bit mode,
> +	even though there is theoretically space in the PAE PTEs.  These
> +	permissions are enforced on data access only and have no effect on
> +	instruction fetches.
> +
> +
> +On PowerPC:
> +
> +	It works by dedicating 5 page table entry bits to a "protection key",
> +	giving 32 possible keys.
> +
> +	There  is  a  user-accessible  register (AMR)  with  two separate bits;
> +	Access Disable and  Write  Disable, for  each key.  Being  a  CPU
> +	register,  AMR  is inherently  thread-local,  potentially  giving  each
> +	thread a different set of protections from every other thread.  NOTE:
> +	Disabling read permission does not disable write and vice-versa.

We can only enable/disable entire access or write. Then how
read permission can be changed with protection keys directly ?

