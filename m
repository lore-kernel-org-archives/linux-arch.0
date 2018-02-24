From: Ram Pai <linuxram@us.ibm.com>
Subject: Re: [PATCH v12 1/3] mm, powerpc, x86: define VM_PKEY_BITx bits if
 CONFIG_ARCH_HAS_PKEYS is enabled
Date: Fri, 23 Feb 2018 17:05:11 -0800
Message-ID: <20180224010511.GK5559@ram.oc3035372033.ibm.com>
References: <1519257138-23797-2-git-send-email-linuxram@us.ibm.com>
 <201802231528.snWZIspR%fengguang.wu@intel.com>
Reply-To: Ram Pai <linuxram@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
Content-Disposition: inline
In-Reply-To: <201802231528.snWZIspR%fengguang.wu@intel.com>
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
To: kbuild test robot <lkp@intel.com>
Cc: kbuild-all@01.org, msuchanek@suse.com, mhocko@kernel.org, dave.hansen@intel.com, paulus@samba.org, khandual@linux.vnet.ibm.com, linux-arch@vger.kernel.org, corbet@lwn.net, x86@kernel.org, mingo@redhat.com, bauerman@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com, arnd@arndb.de, fweimer@redhat.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org, ebiederm@xmission.com, akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org
List-Id: linux-arch.vger.kernel.org

On Fri, Feb 23, 2018 at 03:11:45PM +0800, kbuild test robot wrote:
> Hi Ram,
> 
> Thank you for the patch! Yet something to improve:
> 
> [auto build test ERROR on linus/master]
> [also build test ERROR on v4.16-rc2 next-20180222]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
> 
>         chmod +x ~/bin/make.cross
...snip..
>         # save the attached .config to linux build tree
>         make.cross ARCH=powerpc 
> 
> Note: the linux-review/Ram-Pai/mm-x86-powerpc-Enhancements-to-Memory-Protection-Keys/20180223-042743 HEAD c5692bca45543c242ffca15c811923e4c548ed19 builds fine.
>       It only hurts bisectibility.

oops, it broke git-bisect on powerpc :-(
The following change will fix it. This should nail it down.

diff --git a/arch/powerpc/include/asm/pkeys.h
b/arch/powerpc/include/asm/pkeys.h
index 0409c80..0b3b669 100644
--- a/arch/powerpc/include/asm/pkeys.h
+++ b/arch/powerpc/include/asm/pkeys.h
@@ -25,6 +25,7 @@
 # define VM_PKEY_BIT1  VM_HIGH_ARCH_1
 # define VM_PKEY_BIT2  VM_HIGH_ARCH_2
 # define VM_PKEY_BIT3  VM_HIGH_ARCH_3
 # define VM_PKEY_BIT4  VM_HIGH_ARCH_4
+#elif !defined(VM_PKEY_BIT4)
+# define VM_PKEY_BIT4  VM_HIGH_ARCH_4
#endif
