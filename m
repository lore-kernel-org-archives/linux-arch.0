From: David Howells <dhowells@redhat.com>
Subject: Re: [PATCH trivial] include: uapi: standard all files' macro prefix
 and suffix, excluding "linux/" sub-directory
Date: Tue, 05 Nov 2013 11:11:36 +0000
Message-ID: <13981.1383649896@warthog.procyon.org.uk>
References: <52786742.1080509@asianux.com> <51FB6216.6010008@asianux.com>
 <11907.1383602624@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <52786742.1080509@asianux.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mtd/>
List-Post: <mailto:linux-mtd@lists.infradead.org>
List-Help: <mailto:linux-mtd-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=subscribe>
Sender: "linux-mtd" <linux-mtd-bounces@lists.infradead.org>
Errors-To: linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org
To: Chen Gang <gang.chen@asianux.com>
Cc: xen-devel@lists.xensource.com, jeremy@goop.org, airlied@linux.ie, daniel.vetter@ffwll.ch, alsa-devel@alsa-project.org, dri-devel@lists.freedesktop.org, perex@perex.cz, dhowells@redhat.com, thierry.reding@gmail.com, linux-mtd@lists.infradead.org, sean.hefty@intel.com, virtualization@lists.linux-foundation.org, Linux-Arch <linux-arch@vger.kernel.org>, "kgene.kim@samsung.com" <kgene.kim@samsung.com>, tbergstrom@nvidia.com, jy0922.shim@samsung.com, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, roland@purestorage.com, Takashi Iwai <tiwai@suse.de>, Tomi Valkeinen <tomi.valkeinen@ti.com>, mtk.manpages@gmail.com, fcoe-devel@open-fcoe.org, Paul McKenney <paulmck@linux.vnet.ibm.com>, "plagnioj@jcrosoft.com" <plagnioj@jcrosoft.com>, Arnd Bergmann <arnd@arndb.de>, swarren@wwwdotorg.org, intel-gfx@lists.freedesktop.org, inki.dae@samsung.com"linux-samsung-soc@vger.kernel.org" <lin>
List-Id: linux-arch.vger.kernel.org


Chen Gang <gang.chen@asianux.com> wrote:

> > Userspace sometimes depends on the name in the guard macro:-/
> 
> "the guard macro" is only for prevent itself from being included by
> multiple times (an id used by itself -- like a handle), it is not an id
> to let other files know about it (it is not a normal using way).

Whilst that *should* be true, it isn't actually true.  See:

	grep -r _LINUX_.*_H /usr/include/ | grep -v ^/usr/include/linux/

for example.  Also who knows what all those autoconf scripts out there look
for?

However, thinking about it some more, you're probably safe with respect to
userspace as scripts/headers_install.h strips off the _UAPI prefix on the
guard macros - just as long as you don't change the rest of the macro name.

David

______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
