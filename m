From: Ram Pai <linuxram@us.ibm.com>
Subject: Re: [PATCH v13 22/24] selftests/vm: testcases must restore
 pkey-permissions
Date: Tue, 17 Jul 2018 09:09:10 -0700
Message-ID: <20180717160910.GG5790@ram.oc3035372033.ibm.com>
References: <1528937115-10132-1-git-send-email-linuxram@us.ibm.com>
 <1528937115-10132-23-git-send-email-linuxram@us.ibm.com>
 <e4e63ab2-2830-9ade-3e5f-6d0f61efbcb6@intel.com>
Reply-To: Ram Pai <linuxram@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
In-Reply-To: <e4e63ab2-2830-9ade-3e5f-6d0f61efbcb6@intel.com>
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

On Wed, Jun 20, 2018 at 08:20:22AM -0700, Dave Hansen wrote:
> On 06/13/2018 05:45 PM, Ram Pai wrote:
> > Generally the signal handler restores the state of the pkey register
> > before returning. However there are times when the read/write operation
> > can legitamely fail without invoking the signal handler.  Eg: A
> > sys_read() operaton to a write-protected page should be disallowed.  In
> > such a case the state of the pkey register is not restored to its
> > original state.  The test case is responsible for restoring the key
> > register state to its original value.
> 
> Seems fragile.  Can't we just do this in common code?  We could just
> loop through and restore the default permissions.  That seems much more
> resistant to a bad test case.

Yes. done. fixed it the way you suggested in the new version.


-- 
Ram Pai
