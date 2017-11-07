From: Ram Pai <linuxram@us.ibm.com>
Subject: Re: [PATCH v9 00/51] powerpc, mm: Memory Protection Keys
Date: Tue, 7 Nov 2017 15:44:27 -0800
Message-ID: <20171107234427.GA5659@ram.oc3035372033.ibm.com>
References: <1509958663-18737-1-git-send-email-linuxram@us.ibm.com>
 <87efpbm706.fsf@mid.deneb.enyo.de>
 <20171107012218.GA5546@ram.oc3035372033.ibm.com>
 <87h8u6lf27.fsf@mid.deneb.enyo.de>
 <20171107223953.GB5546@ram.oc3035372033.ibm.com>
 <8b970e5b-50e6-bcc1-e8d3-6e3aa8523f55@intel.com>
Reply-To: Ram Pai <linuxram@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <8b970e5b-50e6-bcc1-e8d3-6e3aa8523f55@intel.com>
Sender: linux-doc-owner@vger.kernel.org
To: Dave Hansen <dave.hansen@intel.com>
Cc: Florian Weimer <fw@deneb.enyo.de>, linux-arch@vger.kernel.org, x86@kernel.org, arnd@arndb.de, corbet@lwn.net, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, mhocko@kernel.org, linux-mm@kvack.org, mingo@redhat.com, paulus@samba.org, ebiederm@xmission.com, linux-kselftest@vger.kernel.org, bauerman@linux.vnet.ibm.com, akpm@linux-foundation.org, khandual@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org, aneesh.kumar@linux.vnet.ibm.com
List-Id: linux-arch.vger.kernel.org

On Tue, Nov 07, 2017 at 02:47:10PM -0800, Dave Hansen wrote:
> On 11/07/2017 02:39 PM, Ram Pai wrote:
> > 
> > As per the current semantics of sys_pkey_free(); the way I understand it,
> > the calling thread is saying disassociate me from this key.
> 
> No.  It is saying: "this *process* no longer has any uses of this key,
> it can be reused".

ok, in light of the corrected semantics, I see no bug in the implimentation.

> On Mon, Nov 06, 2017 at 10:28:41PM +0100, Florian Weimer wrote:
...
> The problem is a pkey_alloc/pthread_create/pkey_free/pkey_alloc
> sequence.  The pthread_create call makes the new thread inherit the
> access rights of the current thread, but then the key is deallocated.
> Reallocation of the same key will have that thread retain its access
> rights, which is IMHO not correct.

Again.. in light of the corrected semantics --
 the child thread or any thread should not free
a key without cleaning up. 
(a) disassociate the key from its address space
(b) reset the permission on the key across all the threads of the
process.

Because any such uncleaned bits can cause unexpected behavior if the 
same key gets reallocated on sys_pkey_alloc().


-- 
Ram Pai

