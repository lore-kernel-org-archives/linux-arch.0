From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [RFC v5 00/38] powerpc: Memory Protection Keys
Date: Wed, 12 Jul 2017 07:30:49 +1000
Message-ID: <1499808649.2865.31.camel@kernel.crashing.org>
References: <1499289735-14220-1-git-send-email-linuxram@us.ibm.com>
	 <20170711145246.GA11917@dhcp22.suse.cz>
	 <20170711193257.GB5525@ram.oc3035372033.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <20170711193257.GB5525@ram.oc3035372033.ibm.com>
Sender: owner-linux-mm@kvack.org
To: Ram Pai <linuxram@us.ibm.com>, Michal Hocko <mhocko@kernel.org>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org, linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, paulus@samba.org, mpe@ellerman.id.au, khandual@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com, bsingharora@gmail.com, dave.hansen@intel.com, hbabu@us.ibm.com, arnd@arndb.de, akpm@linux-foundation.org, corbet@lwn.net, mingo@redhat.com
List-Id: linux-arch.vger.kernel.org

On Tue, 2017-07-11 at 12:32 -0700, Ram Pai wrote:
> Ideally the MMU looks at the PTE for keys, in order to enforce
> protection. This is the case with x86 and is the case with power9 Radix
> page table. Hence the keys have to be programmed into the PTE.

POWER9 radix doesn't currently support keys.

Cheers,
Ben.

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
