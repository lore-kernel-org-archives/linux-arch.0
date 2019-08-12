From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH v7 1/2] arm64: Define
 Documentation/arm64/tagged-address-abi.rst
Date: Mon, 12 Aug 2019 18:17:35 +0100
Message-ID: <20190812171734.GC62772@arrakis.emea.arm.com>
References: <20190807155321.9648-1-catalin.marinas@arm.com>
 <20190807155321.9648-2-catalin.marinas@arm.com>
 <20190808170424.6td34cpdngkcxxpu@willie-the-truck>
 <20190812104606.GY56241@e119886-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20190812104606.GY56241@e119886-lin.cambridge.arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Andrew Murray <andrew.murray@arm.com>
Cc: linux-arch@vger.kernel.org, linux-doc@vger.kernel.org, Szabolcs Nagy <szabolcs.nagy@arm.com>, Andrey Konovalov <andreyknvl@google.com>, Kevin Brodsky <kevin.brodsky@arm.com>, Will Deacon <will.deacon@arm.com>, Dave Hansen <dave.hansen@intel.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>, Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-arch.vger.kernel.org

On Mon, Aug 12, 2019 at 11:46:06AM +0100, Andrew Murray wrote:
> On Thu, Aug 08, 2019 at 06:04:24PM +0100, Will Deacon wrote:
> > On Wed, Aug 07, 2019 at 04:53:20PM +0100, Catalin Marinas wrote:
> > > +
> > > +- mmap() addr parameter.
> > > +
> > > +- mremap() new_address parameter.
> > > +
> > > +- prctl(PR_SET_MM, ``*``, ...) other than arg2 PR_SET_MM_MAP and
> > > +  PR_SET_MM_MAP_SIZE.
> > > +
> > > +- prctl(PR_SET_MM, PR_SET_MM_MAP{,_SIZE}, ...) struct prctl_mm_map fields.
> > 
> > How did you generate this list and who will keep it up to date? How do you
> > know you haven't missed anything?
> 
> What about shared memory system calls: shmat, shmdt? The latest "arm64: untag
> user pointers passed to the kernel" series doesn't untag these, thus we should
> indicate here that these too are no supported.

Yes. We dropped them from a previous version of the series but they've
never been documented. I'll add something (unless someone has a real
use-case for using tags with shmat/shmdt).

-- 
Catalin
