From: Ram Pai <linuxram@us.ibm.com>
Subject: Re: [PATCH v13 17/24] selftests/vm: powerpc implementation to check
 support for pkey
Date: Tue, 17 Jul 2018 09:05:16 -0700
Message-ID: <20180717160516.GE5790@ram.oc3035372033.ibm.com>
References: <1528937115-10132-1-git-send-email-linuxram@us.ibm.com>
 <1528937115-10132-18-git-send-email-linuxram@us.ibm.com>
 <20bc9696-3ae9-4eb9-40ce-9c477a8aaea2@intel.com>
Reply-To: Ram Pai <linuxram@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
In-Reply-To: <20bc9696-3ae9-4eb9-40ce-9c477a8aaea2@intel.com>
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

On Wed, Jun 20, 2018 at 08:09:12AM -0700, Dave Hansen wrote:
> > -	if (cpu_has_pku()) {
> > -		dprintf1("SKIP: %s: no CPU support\n", __func__);
> > +	if (is_pkey_supported()) {
> > +		dprintf1("SKIP: %s: no CPU/kernel support\n", __func__);
> >  		return;
> >  	}
> 
> I actually kinda wanted a specific message for when the *CPU* doesn't
> support the feature.

is_pkey_supported() x86 implementation has specific messages. it will
print if the CPU doesn't support the feature.

RP

-- 
Ram Pai
