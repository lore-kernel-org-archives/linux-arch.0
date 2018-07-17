From: Ram Pai <linuxram@us.ibm.com>
Subject: Re: [PATCH v13 16/24] selftests/vm: clear the bits in shadow reg
 when a pkey is freed.
Date: Tue, 17 Jul 2018 09:03:51 -0700
Message-ID: <20180717160351.GD5790@ram.oc3035372033.ibm.com>
References: <1528937115-10132-1-git-send-email-linuxram@us.ibm.com>
 <1528937115-10132-17-git-send-email-linuxram@us.ibm.com>
 <0b534ee8-5747-2811-745c-d87b3e720955@intel.com>
Reply-To: Ram Pai <linuxram@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
In-Reply-To: <0b534ee8-5747-2811-745c-d87b3e720955@intel.com>
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

On Wed, Jun 20, 2018 at 08:07:31AM -0700, Dave Hansen wrote:
> On 06/13/2018 05:45 PM, Ram Pai wrote:
> > --- a/tools/testing/selftests/vm/protection_keys.c
> > +++ b/tools/testing/selftests/vm/protection_keys.c
> > @@ -577,7 +577,8 @@ int sys_pkey_free(unsigned long pkey)
> >  	int ret = syscall(SYS_pkey_free, pkey);
> >  
> >  	if (!ret)
> > -		shadow_pkey_reg &= clear_pkey_flags(pkey, PKEY_DISABLE_ACCESS);
> > +		shadow_pkey_reg &= clear_pkey_flags(pkey,
> > +				PKEY_DISABLE_ACCESS | PKEY_DISABLE_WRITE);
> >  	dprintf1("%s(pkey=%ld) syscall ret: %d\n", __func__, pkey, ret);
> >  	return ret;
> >  }
> 
> Why did you introduce this code earlier and then modify it now?
> 
> BTW, my original aversion to this code still stands.

Have entirely got rid of this code in the new version.

-- 
Ram Pai
