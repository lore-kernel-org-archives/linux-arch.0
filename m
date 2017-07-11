From: Ram Pai <linuxram@us.ibm.com>
Subject: Re: [RFC v5 12/38] mm: ability to disable execute permission on a
 key at creation
Date: Tue, 11 Jul 2017 15:19:30 -0700
Message-ID: <20170711221929.GC5542@ram.oc3035372033.ibm.com>
References: <1499289735-14220-1-git-send-email-linuxram@us.ibm.com>
 <1499289735-14220-13-git-send-email-linuxram@us.ibm.com>
 <3bd2ffd4-33ad-ce23-3db1-d1292e69ca9b@intel.com>
 <1499808577.2865.30.camel@kernel.crashing.org>
 <20170711215105.GA5542@ram.oc3035372033.ibm.com>
 <1499810936.2865.32.camel@kernel.crashing.org>
Reply-To: Ram Pai <linuxram@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <owner-linux-mm@kvack.org>
Content-Disposition: inline
In-Reply-To: <1499810936.2865.32.camel@kernel.crashing.org>
Sender: owner-linux-mm@kvack.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linux-arch@vger.kernel.org, corbet@lwn.net, arnd@arndb.de, linux-mm@kvack.org, x86@kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Dave Hansen <dave.hansen@intel.com>, mingo@redhat.com, paulus@samba.org, aneesh.kumar@linux.vnet.ibm.com, linux-kselftest@vger.kernel.org, akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org, khandual@linux.vnet.ibm.com
List-Id: linux-arch.vger.kernel.org

On Wed, Jul 12, 2017 at 08:08:56AM +1000, Benjamin Herrenschmidt wrote:
> On Tue, 2017-07-11 at 14:51 -0700, Ram Pai wrote:
> > On Wed, Jul 12, 2017 at 07:29:37AM +1000, Benjamin Herrenschmidt wrote:
> > > On Tue, 2017-07-11 at 11:11 -0700, Dave Hansen wrote:
> > > > On 07/05/2017 02:21 PM, Ram Pai wrote:
> > > > > Currently sys_pkey_create() provides the ability to disable read
> > > > > and write permission on the key, at  creation. powerpc  has  the
> > > > > hardware support to disable execute on a pkey as well.This patch
> > > > > enhances the interface to let disable execute  at  key  creation
> > > > > time. x86 does  not  allow  this.  Hence the next patch will add
> > > > > ability  in  x86  to  return  error  if  PKEY_DISABLE_EXECUTE is
> > > > > specified.
> > > 
> > > That leads to the question... How do you tell userspace.
> > > 
> > > (apologies if I missed that in an existing patch in the series)
> > > 
> > > How do we inform userspace of the key capabilities ? There are at least
> > > two things userspace may want to know already:
> > > 
> > >  - What protection bits are supported for a key
> > 
> > the userspace is the one which allocates the keys and enables/disables the
> > protection bits on the key. the kernel is just a facilitator. Now if the
> > use space wants to know the current permissions on a given key, it can
> > just read the AMR/PKRU register on powerpc/intel respectively.
> 
> You misunderstand. How does userspace knows on a given system whether
> execute permission control is supported for keys ?

Ah..sorry. did not catch that part.

Yes the current patch set does not make that information available. The
indirect way of find this out is, to try to allocate a key with
execute-disable permission and decide based on the pass/fail status.

we can expose that information through a procfs/sysfs interface.

RP

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
