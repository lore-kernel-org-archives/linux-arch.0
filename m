From: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
Subject: Re: [PATCH v15 06/23] selftests/vm/pkeys: Typecast the pkey register
Date: Wed, 18 Dec 2019 22:45:31 +0100
Message-ID: <20191218214531.GI4113@kitsune.suse.cz>
References: <cover.1576645161.git.sandipan@linux.ibm.com>
 <719ec65756a64cc03e8464a9c6da51c4519d2389.1576645161.git.sandipan@linux.ibm.com>
 <5b6c3f8a-9d2f-2534-c072-89f130ce110f@intel.com>
 <20191218205905.GG4113@kitsune.suse.cz>
 <15c3b6cc-d8da-9a32-da6a-4c3990f48994@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
Content-Disposition: inline
In-Reply-To: <15c3b6cc-d8da-9a32-da6a-4c3990f48994@intel.com>
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
Cc: linux-arch@vger.kernel.org, fweimer@redhat.com, aneesh.kumar@linux.ibm.com, x86@kernel.org, linuxram@us.ibm.com, shuahkh@osg.samsung.com, mhocko@kernel.org, linux-mm@kvack.org, mingo@redhat.com, Sandipan Das <sandipan@linux.ibm.com>, linux-kselftest@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, bauerman@linux.ibm.com
List-Id: linux-arch.vger.kernel.org

On Wed, Dec 18, 2019 at 01:01:46PM -0800, Dave Hansen wrote:
> On 12/18/19 12:59 PM, Michal Suchánek wrote:
> >> I'd really just rather do %016lx *everywhere* than sprinkle the
> >> PKEY_REG_FMTs around.
> > Does lx work with u32 without warnings?
> 
> Either way, I'd be happy to just make the x86 one u64 to make the whole
> thing look more sane,

So long as it still works with u64 on x86 it should be pretty
future-proof.  Does not look like we are getting 128bit registers for
anything but math units any time soon.

Thanks

Michal
