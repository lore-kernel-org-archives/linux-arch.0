From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [RFC v5 12/38] mm: ability to disable execute permission on a
 key at creation
Date: Wed, 12 Jul 2017 07:29:37 +1000
Message-ID: <1499808577.2865.30.camel@kernel.crashing.org>
References: <1499289735-14220-1-git-send-email-linuxram@us.ibm.com>
	 <1499289735-14220-13-git-send-email-linuxram@us.ibm.com>
	 <3bd2ffd4-33ad-ce23-3db1-d1292e69ca9b@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <3bd2ffd4-33ad-ce23-3db1-d1292e69ca9b@intel.com>
Sender: owner-linux-mm@kvack.org
To: Dave Hansen <dave.hansen@intel.com>, Ram Pai <linuxram@us.ibm.com>, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org, linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc: paulus@samba.org, mpe@ellerman.id.au, khandual@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com, bsingharora@gmail.com, hbabu@us.ibm.com, arnd@arndb.de, akpm@linux-foundation.org, corbet@lwn.net, mingo@redhat.com
List-Id: linux-arch.vger.kernel.org

On Tue, 2017-07-11 at 11:11 -0700, Dave Hansen wrote:
> On 07/05/2017 02:21 PM, Ram Pai wrote:
> > Currently sys_pkey_create() provides the ability to disable read
> > and write permission on the key, at  creation. powerpc  has  the
> > hardware support to disable execute on a pkey as well.This patch
> > enhances the interface to let disable execute  at  key  creation
> > time. x86 does  not  allow  this.  Hence the next patch will add
> > ability  in  x86  to  return  error  if  PKEY_DISABLE_EXECUTE is
> > specified.

That leads to the question... How do you tell userspace.

(apologies if I missed that in an existing patch in the series)

How do we inform userspace of the key capabilities ? There are at least
two things userspace may want to know already:

 - What protection bits are supported for a key

 - How many keys exist

 - Which keys are available for use by userspace. On PowerPC, the
kernel can reserve some keys for itself, so can the hypervisor. In
fact, they do.

Cheers,
Ben.

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
