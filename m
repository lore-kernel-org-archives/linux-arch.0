From: Ram Pai <linuxram@us.ibm.com>
Subject: mm, x86, powerpc: pkey semantics for key-0 ?
Date: Thu, 8 Mar 2018 10:25:17 -0800
Message-ID: <20180308182517.GO1060@ram.oc3035372033.ibm.com>
References: <1519257138-23797-1-git-send-email-linuxram@us.ibm.com>
 <1519257138-23797-4-git-send-email-linuxram@us.ibm.com>
 <2a7737cf-a5ba-c814-fdc7-45b5cdd47376@intel.com>
Reply-To: Ram Pai <linuxram@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <2a7737cf-a5ba-c814-fdc7-45b5cdd47376@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dave Hansen <dave.hansen@intel.com>
Cc: mpe@ellerman.id.au, mingo@redhat.com, akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org, x86@kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, benh@kernel.crashing.org, paulus@samba.org, khandual@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com, bsingharora@gmail.com, hbabu@us.ibm.com, mhocko@kernel.org, bauerman@linux.vnet.ibm.com, ebiederm@xmission.com, corbet@lwn.net, arnd@arndb.de, fweimer@redhat.com, msuchanek@suse.com, Ulrich.Weigand@de.ibm.com
List-Id: linux-arch.vger.kernel.org

Dave,

Is there a reason why the default key; key-0, is not allowed to be
explicitly associated with pages using pkey_mprotect()?

I see valid usecases where an application may initially want to
associate an address-range with some key and latter choose to revert to
its initial state, by associating key-0.  However our implementation
(both x86 and power) do not allow pkey_mprotect() to be called with
key-0.

I do not see a reason why it must be blocked.

Thoughts?
RP
