From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 07/10] powerpc: uaccess s/might_sleep/might_fault/
Date: Fri, 24 May 2013 15:30:20 +0200
Message-ID: <201305241530.20845.arnd@arndb.de>
References: <cover.1368702323.git.mst@redhat.com>
 <20130524130032.GA10167@redhat.com> <20130524131104.GA11462@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20130524131104.GA11462@redhat.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-m32r-ja@ml.linux-m32r.org, kvm@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, David Howells <dhowells@redhat.com>, linux-mm@kvack.org, Paul Mackerras <paulus@samba.org>, "H. Peter Anvin" <hpa@zytor.com>, linux-arch@vger.kernel.org, linux-am33-list@redhat.com, Hirokazu Takata <takata@linux-m32r.org>, x86@kernel.org, Ingo Molnar <mingo@redhat.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, microblaze-uclinux@itee.uq.edu.au, Chris Metcalf <cmetcalf@tilera.com>, Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org, Michal Simek <monstr@monstr.eu>, linux-m32r@ml.linux-m32r.org, linux-kernel@vger.kernel.org, Koichi Yasutake <yasutake.koichi@jp.panasonic.com>, linuxppc-dev@lists.ozlabs.org
List-Id: linux-arch.vger.kernel.org

On Friday 24 May 2013, Michael S. Tsirkin wrote:
> So this won't work, unless we add the is_kernel_addr check
> to might_fault. That will become possible on top of this patchset
> but let's consider this carefully, and make this a separate
> patchset, OK?

Yes, makes sense.

	Arnd
