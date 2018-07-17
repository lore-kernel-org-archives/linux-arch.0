From: Ram Pai <linuxram@us.ibm.com>
Subject: Re: [PATCH v13 13/24] selftests/vm: pkey register should match
 shadow pkey
Date: Tue, 17 Jul 2018 09:02:18 -0700
Message-ID: <20180717160218.GC5790@ram.oc3035372033.ibm.com>
References: <1528937115-10132-1-git-send-email-linuxram@us.ibm.com>
 <1528937115-10132-14-git-send-email-linuxram@us.ibm.com>
 <6246f823-77d9-6727-097e-73f103078a44@intel.com>
Reply-To: Ram Pai <linuxram@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
In-Reply-To: <6246f823-77d9-6727-097e-73f103078a44@intel.com>
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

On Wed, Jun 20, 2018 at 07:53:57AM -0700, Dave Hansen wrote:
> On 06/13/2018 05:45 PM, Ram Pai wrote:
> > +++ b/tools/testing/selftests/vm/protection_keys.c
> > @@ -916,10 +916,10 @@ void expected_pkey_fault(int pkey)
> >  		pkey_assert(last_si_pkey == pkey);
> >  
> >  	/*
> > -	 * The signal handler shold have cleared out PKEY register to let the
> > +	 * The signal handler should have cleared out pkey-register to let the
> >  	 * test program continue.  We now have to restore it.
> >  	 */
> > -	if (__read_pkey_reg() != 0)
> > +	if (__read_pkey_reg() != shadow_pkey_reg)
> >  		pkey_assert(0);
> >  
> >  	__write_pkey_reg(shadow_pkey_reg);
> 
> I think this is wrong on x86.
> 
> When we leave the signal handler, we zero out PKRU so that the faulting
> instruction can continue, that's why we have the check against zero.
> I'm actually kinda surprised this works.

The code is modified to zero out only the violated key in the signal
handler. Hence it works. Have verified it to work on x86 aswell.

RP
