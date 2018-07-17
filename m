From: Ram Pai <linuxram@us.ibm.com>
Subject: Re: [PATCH v13 19/24] selftests/vm: associate key on a mapped page
 and detect access violation
Date: Tue, 17 Jul 2018 09:13:32 -0700
Message-ID: <20180717161332.GH5790@ram.oc3035372033.ibm.com>
References: <1528937115-10132-1-git-send-email-linuxram@us.ibm.com>
 <1528937115-10132-20-git-send-email-linuxram@us.ibm.com>
 <048b1de9-85f8-22ff-a31a-b06a382769bb@intel.com>
Reply-To: Ram Pai <linuxram@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
In-Reply-To: <048b1de9-85f8-22ff-a31a-b06a382769bb@intel.com>
Content-Disposition: inline
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
To: Dave Hansen <dave.hansen@intel.com>
Cc: linux-arch@vger.kernel.org, fweimer@redhat.com, x86@kernel.org, shuahkh@osg.samsung.com, mhocko@kernel.org, linux-mm@kvack.org, mingo@redhat.com, aneesh.kumar@linux.vnet.ibm.com, linux-kselftest@vger.kernel.org, bauerman@linux.vnet.ibm.com, msuchanek@suse.de, linuxppc-dev@lists.ozlabs.org
List-Id: linux-arch.vger.kernel.org

On Wed, Jun 20, 2018 at 08:16:44AM -0700, Dave Hansen wrote:
> On 06/13/2018 05:45 PM, Ram Pai wrote:
> > +void test_read_of_access_disabled_region_with_page_already_mapped(int *ptr,
> > +		u16 pkey)
> > +{
> > +	int ptr_contents;
> > +
> > +	dprintf1("disabling access to PKEY[%02d], doing read @ %p\n",
> > +				pkey, ptr);
> > +	ptr_contents = read_ptr(ptr);
> > +	dprintf1("reading ptr before disabling the read : %d\n",
> > +			ptr_contents);
> > +	read_pkey_reg();
> > +	pkey_access_deny(pkey);
> > +	ptr_contents = read_ptr(ptr);
> > +	dprintf1("*ptr: %d\n", ptr_contents);
> > +	expected_pkey_fault(pkey);
> > +}
> 
> Looks fine to me.  I'm a bit surprised we didn't do this already, which
> is a good thing for this patch.
> 
> FWIW, if you took patches like this and put them first, you could
> probably get it merged now.  Yes, I know it would mean redoing some of
> the later code move and rename ones.

I have incorporated almost all of your comments. But there are some
comments that take some effort to implement. Shall we get the patches
merged in the current form?  This code has been sitting out for a while.

In the current form its tested and works on powerpc and on x86, and
incorporates about 95% of your suggestions. The rest I will take care
as we go.

-- 
Ram Pai
