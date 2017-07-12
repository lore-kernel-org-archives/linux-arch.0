From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [RFC v5 11/38] mm: introduce an additional vma bit for powerpc
 pkey
Date: Thu, 13 Jul 2017 08:40:28 +1000
Message-ID: <1499899228.2865.43.camel@kernel.crashing.org>
References: <1499289735-14220-1-git-send-email-linuxram@us.ibm.com>
	 <1499289735-14220-12-git-send-email-linuxram@us.ibm.com>
	 <290636b0-aafd-9bcd-d309-4cff41ce923c@intel.com>
	 <20170712222331.GD5525@ram.oc3035372033.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <20170712222331.GD5525@ram.oc3035372033.ibm.com>
Sender: owner-linux-mm@kvack.org
To: Ram Pai <linuxram@us.ibm.com>, Dave Hansen <dave.hansen@intel.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org, linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, paulus@samba.org, mpe@ellerman.id.au, khandual@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com, bsingharora@gmail.com, hbabu@us.ibm.com, arnd@arndb.de, akpm@linux-foundation.org, corbet@lwn.net, mingo@redhat.com
List-Id: linux-arch.vger.kernel.org

On Wed, 2017-07-12 at 15:23 -0700, Ram Pai wrote:
> Just copying over makes checkpatch.pl unhappy. It exceeds 80 columns.

Which is fine to ignore in a case like that where you remain consistent
with the existing code.

Ben.

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
