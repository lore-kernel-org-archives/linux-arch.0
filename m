From: Ram Pai <linuxram@us.ibm.com>
Subject: Re: [PATCH] x86, powerpc : pkey-mprotect must allow pkey-0
Date: Fri, 9 Mar 2018 21:55:44 -0800
Message-ID: <20180310055544.GU1060@ram.oc3035372033.ibm.com>
References: <1520583161-11741-1-git-send-email-linuxram@us.ibm.com>
 <60886e4a-59d4-541a-a6af-d4504e6719ad@intel.com>
Reply-To: Ram Pai <linuxram@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <60886e4a-59d4-541a-a6af-d4504e6719ad@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dave Hansen <dave.hansen@intel.com>
Cc: mpe@ellerman.id.au, mingo@redhat.com, akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org, x86@kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, benh@kernel.crashing.org, paulus@samba.org, khandual@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com, bsingharora@gmail.com, hbabu@us.ibm.com, mhocko@kernel.org, bauerman@linux.vnet.ibm.com, ebiederm@xmission.com, corbet@lwn.net, arnd@arndb.de, fweimer@redhat.com, msuchanek@suse.com, Ulrich.Weigand@de.ibm.com
List-Id: linux-arch.vger.kernel.org

On Fri, Mar 09, 2018 at 02:40:32PM -0800, Dave Hansen wrote:
> On 03/09/2018 12:12 AM, Ram Pai wrote:
> > Once an address range is associated with an allocated pkey, it cannot be
> > reverted back to key-0. There is no valid reason for the above behavior.  On
> > the contrary applications need the ability to do so.
> 
> Why don't we just set pkey 0 to be allocated in the allocation bitmap by
> default?

ok. that will make it allocatable. But it will not be associatable,
given the bug in the current code. And what will be the
default key associated with a pte? zero? or something else?

> 
> We *could* also just not let it be special and let it be freed.  An app
> could theoretically be careful and make sure nothing is using it.

unable to see how this solves the problem. Need some more explaination.


RP
