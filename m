From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [PATCH v12 1/3] mm, powerpc, x86: define VM_PKEY_BITx bits if
 CONFIG_ARCH_HAS_PKEYS is enabled
Date: Sun, 25 Feb 2018 17:27:11 +0530
Message-ID: <43082fe4-a6e4-2468-0069-4fbc53418c79@linux.vnet.ibm.com>
References: <1519257138-23797-2-git-send-email-linuxram@us.ibm.com>
 <201802231528.snWZIspR%fengguang.wu@intel.com>
 <20180224010511.GK5559@ram.oc3035372033.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
In-Reply-To: <20180224010511.GK5559@ram.oc3035372033.ibm.com>
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
To: Ram Pai <linuxram@us.ibm.com>, kbuild test robot <lkp@intel.com>
Cc: msuchanek@suse.com, mhocko@kernel.org, dave.hansen@intel.com, paulus@samba.org, khandual@linux.vnet.ibm.com, linux-arch@vger.kernel.org, corbet@lwn.net, x86@kernel.org, mingo@redhat.com, bauerman@linux.vnet.ibm.com, kbuild-all@01.org, arnd@arndb.de, fweimer@redhat.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org, ebiederm@xmission.com, akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org
List-Id: linux-arch.vger.kernel.org



On 02/24/2018 06:35 AM, Ram Pai wrote:
> On Fri, Feb 23, 2018 at 03:11:45PM +0800, kbuild test robot wrote:
>> Hi Ram,
>>
>> Thank you for the patch! Yet something to improve:
>>
>> [auto build test ERROR on linus/master]
>> [also build test ERROR on v4.16-rc2 next-20180222]
>> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
>>
>>          chmod +x ~/bin/make.cross
> ...snip..
>>          # save the attached .config to linux build tree
>>          make.cross ARCH=powerpc
>>
>> Note: the linux-review/Ram-Pai/mm-x86-powerpc-Enhancements-to-Memory-Protection-Keys/20180223-042743 HEAD c5692bca45543c242ffca15c811923e4c548ed19 builds fine.
>>        It only hurts bisectibility.
> 
> oops, it broke git-bisect on powerpc :-(
> The following change will fix it. This should nail it down.
> 
> diff --git a/arch/powerpc/include/asm/pkeys.h
> b/arch/powerpc/include/asm/pkeys.h
> index 0409c80..0b3b669 100644
> --- a/arch/powerpc/include/asm/pkeys.h
> +++ b/arch/powerpc/include/asm/pkeys.h
> @@ -25,6 +25,7 @@
>   # define VM_PKEY_BIT1  VM_HIGH_ARCH_1
>   # define VM_PKEY_BIT2  VM_HIGH_ARCH_2
>   # define VM_PKEY_BIT3  VM_HIGH_ARCH_3
>   # define VM_PKEY_BIT4  VM_HIGH_ARCH_4
> +#elif !defined(VM_PKEY_BIT4)
> +# define VM_PKEY_BIT4  VM_HIGH_ARCH_4
> #endif
> 

Why don't you remove this powerpc definition completely in this patch? 
Also move that comment above #define. The comments are not specific to
BIT1

@@ -231,9 +231,10 @@ extern int overcommit_kbytes_handler(struct 
ctl_table *, int, void __user *,
  #ifdef CONFIG_ARCH_HAS_PKEYS
  # define VM_PKEY_SHIFT	VM_HIGH_ARCH_BIT_0
  # define VM_PKEY_BIT0	VM_HIGH_ARCH_0	/* A protection key is a 4-bit 
value */
-# define VM_PKEY_BIT1	VM_HIGH_ARCH_1
+# define VM_PKEY_BIT1	VM_HIGH_ARCH_1	/* on x86 and 5-bit value on ppc64 
   */
  # define VM_PKEY_BIT2	VM_HIGH_ARCH_2
  # define VM_PKEY_BIT3	VM_HIGH_ARCH_3
+# define VM_PKEY_BIT4	VM_HIGH_ARCH_4
  #endif /* CONFIG_ARCH_HAS_PKEYS */



-aneesh
