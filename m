From: Ram Pai <linuxram@us.ibm.com>
Subject: Re: [PATCH v9 00/51] powerpc, mm: Memory Protection Keys
Date: Thu, 9 Nov 2017 14:23:29 -0800
Message-ID: <20171109222329.GB5656@ram.oc3035372033.ibm.com>
References: <1509958663-18737-1-git-send-email-linuxram@us.ibm.com>
 <87efpbm706.fsf@mid.deneb.enyo.de>
 <20171107012218.GA5546@ram.oc3035372033.ibm.com>
Reply-To: Ram Pai <linuxram@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171107012218.GA5546@ram.oc3035372033.ibm.com>
Sender: linux-doc-owner@vger.kernel.org
To: Florian Weimer <fw@deneb.enyo.de>
Cc: mpe@ellerman.id.au, mingo@redhat.com, akpm@linux-foundation.org, corbet@lwn.net, arnd@arndb.de, linux-arch@vger.kernel.org, ebiederm@xmission.com, linux-doc@vger.kernel.org, x86@kernel.org, dave.hansen@intel.com, linux-kernel@vger.kernel.org, mhocko@kernel.org, linux-mm@kvack.org, paulus@samba.org, aneesh.kumar@linux.vnet.ibm.com, linux-kselftest@vger.kernel.org, bauerman@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org, khandual@linux.vnet.ibm.com
List-Id: linux-arch.vger.kernel.org

On Mon, Nov 06, 2017 at 05:22:18PM -0800, Ram Pai wrote:
> On Mon, Nov 06, 2017 at 10:28:41PM +0100, Florian Weimer wrote:
> > * Ram Pai:
> > 
> > > Testing:
> > > -------
> > > This patch series has passed all the protection key
> > > tests available in the selftest directory.The
> > > tests are updated to work on both x86 and powerpc.
> > > The selftests have passed on x86 and powerpc hardware.
> > 
....snip....

> > What about siglongjmp from a signal handler?
> 
> On powerpc there is some relief.  the permissions on a key can be
> modified from anywhere, including from the signal handler, and the
> effect will be immediate.  You dont have to wait till the
> signal handler returns for the key permissions to be restore.
> 
> also after return from the sigsetjmp();
> possibly caused by siglongjmp(), the program can restore the permission
> on any key.
> 
> Atleast that is my theory. Can you give me a testcase; if you have one
> handy.
> 
> > 
> >   <https://sourceware.org/bugzilla/show_bug.cgi?id=22396>
> > 

reading through the bug report, you mention that the following
"The application may not be able to save and restore the protection bits
for all keys because the kernel API does not actually specify that the
set of keys is a small, fixed set."

What exact kernel API do you need? This patch set exposes the total
number of keys and  max keys,  through sysfs.
https://marc.info/?l=linux-kernel&m=150995950219669&w=2

Is this sufficient? or do you need something else?

RP

