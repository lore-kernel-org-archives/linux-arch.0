From: "Luck, Tony" <tony.luck@intel.com>
Subject: RE: [PATCH 20/34] ia64: define __smp_XXX
Date: Wed, 30 Dec 2015 16:43:00 +0000
Message-ID: <3908561D78D1C84285E8C5FCA982C28F39F9D09A@ORSMSX114.amr.corp.intel.com>
References: <1451473761-30019-1-git-send-email-mst@redhat.com>
	<1451473761-30019-21-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1451473761-30019-21-git-send-email-mst@redhat.com>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "Yu,
	Fenghua" <fenghua.yu@intel.com>, "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Stefano Stabellini <stefano.stabellini@eu.citrix.com>, Peter Zijlstra <peterz@infradead.org>, Andrew Cooper <andrew.cooper3@citrix.com>, Davidlohr Bueso <dbueso@suse.de>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, Andrey Konovalov <andreyknvl@google.com>, Ingo Molnar <mingo@kernel.org>
List-Id: linux-arch.vger.kernel.org

> This defines __smp_XXX barriers for ia64,
> for use by virtualization.
>
> smp_XXX barriers are removed as they are
> defined correctly by asm-generic/barriers.h
>
> This reduces the amount of arch-specific boiler-plate code.

Acked-by: Tony Luck <tony.luck@intel.com>
