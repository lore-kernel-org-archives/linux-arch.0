From: Ram Pai <linuxram@us.ibm.com>
Subject: Re: [PATCH v9 29/51] mm/mprotect, powerpc/mm/pkeys, x86/mm/pkeys:
 Add sysfs interface
Date: Tue, 19 Dec 2017 08:22:21 -0800
Message-ID: <20171219162221.GB5481@ram.oc3035372033.ibm.com>
References: <1509958663-18737-1-git-send-email-linuxram@us.ibm.com>
 <1509958663-18737-30-git-send-email-linuxram@us.ibm.com>
 <bbc5593e-31ec-183a-01a5-1a253dc0c275@intel.com>
 <20171218221850.GD5461@ram.oc3035372033.ibm.com>
 <e7971d03-6ad1-40d5-9b79-f01242db5293@intel.com>
 <20171218231551.GA5481@ram.oc3035372033.ibm.com>
 <20171219083122.q7ycxg2dfspgzw7z@lt-gp.iram.es>
Reply-To: Ram Pai <linuxram@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171219083122.q7ycxg2dfspgzw7z@lt-gp.iram.es>
Sender: linux-doc-owner@vger.kernel.org
To: Gabriel Paubert <paubert@iram.es>
Cc: linux-arch@vger.kernel.org, corbet@lwn.net, arnd@arndb.de, linux-doc@vger.kernel.org, aneesh.kumar@linux.vnet.ibm.com, x86@kernel.org, linux-kernel@vger.kernel.org, mhocko@kernel.org, linux-mm@kvack.org, Dave Hansen <dave.hansen@intel.com>, mingo@redhat.com, paulus@samba.org, ebiederm@xmission.com, linux-kselftest@vger.kernel.org, bauerman@linux.vnet.ibm.com, akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org, khandual@linux.vnet.ibm.com
List-Id: linux-arch.vger.kernel.org

On Tue, Dec 19, 2017 at 09:31:22AM +0100, Gabriel Paubert wrote:
> On Mon, Dec 18, 2017 at 03:15:51PM -0800, Ram Pai wrote:
> > On Mon, Dec 18, 2017 at 02:28:14PM -0800, Dave Hansen wrote:
> > > On 12/18/2017 02:18 PM, Ram Pai wrote:
> > > 
....snip...
> > > > I think on x86 you look for some hardware registers to determine
> > > > which hardware features are enabled by the kernel.
> > > 
> > > No, we use CPUID.  It's a part of the ISA that's designed for
> > > enumerating CPU and (sometimes) OS support for CPU features.
> > > 
> > > > We do not have generic support for something like that on ppc.  The
> > > > kernel looks at the device tree to determine what hardware features
> > > > are available. But does not have mechanism to tell the hardware to
> > > > track which of its features are currently enabled/used by the
> > > > kernel; atleast not for the memory-key feature.
> > > 
> > > Bummer.  You're missing out.
> > > 
> > > But, you could still do this with a syscall.  "Hey, kernel, do you
> > > support this feature?"
> > 
> > or do powerpc specific sysfs interface.
> > or a debugfs interface.
> 
> getauxval(3) ?
> 
> With AT_HWCAP or HWCAP2 as parameter already gives information about
> features supported by the hardware and the kernel.
> 
> Taking one bit to expose the availability of protection keys to
> applications does not look impossible.
> 
> Do I miss something obvious?

No. I am told this is possible aswell.

RP

