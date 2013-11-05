From: Chen Gang <gang.chen@asianux.com>
Subject: Re: [PATCH trivial] include: uapi: standard all files' macro prefix
	and suffix, excluding "linux/" sub-directory
Date: Tue, 05 Nov 2013 20:05:12 +0800
Message-ID: <5278DEF8.2030101@asianux.com>
References: <52786742.1080509@asianux.com> <51FB6216.6010008@asianux.com>
	<11907.1383602624@warthog.procyon.org.uk>
	<13981.1383649896@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <13981.1383649896@warthog.procyon.org.uk>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: David Howells <dhowells@redhat.com>
Cc: xen-devel@lists.xensource.com, jeremy@goop.org, airlied@linux.ie, daniel.vetter@ffwll.ch, alsa-devel@alsa-project.org, dri-devel@lists.freedesktop.org, perex@perex.cz, thierry.reding@gmail.com, linux-mtd@lists.infradead.org, sean.hefty@intel.com, virtualization@lists.linux-foundation.org, Linux-Arch <linux-arch@vger.kernel.org>, "kgene.kim@samsung.com" <kgene.kim@samsung.com>, tbergstrom@nvidia.com, jy0922.shim@samsung.com, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, roland@purestorage.com, Takashi Iwai <tiwai@suse.de>, Tomi Valkeinen <tomi.valkeinen@ti.com>, mtk.manpages@gmail.com, fcoe-devel@open-fcoe.org, Paul McKenney <paulmck@linux.vnet.ibm.com>, "plagnioj@jcrosoft.com" <plagnioj@jcrosoft.com>, Arnd Bergmann <arnd@arndb.de>, swarren@wwwdotorg.org, intel-gfx@lists.freedesktop.org, inki.dae@samsung.com, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger>
List-Id: linux-arch.vger.kernel.org

On 11/05/2013 07:11 PM, David Howells wrote:
> Chen Gang <gang.chen@asianux.com> wrote:
> 
>>> Userspace sometimes depends on the name in the guard macro:-/
>>
>> "the guard macro" is only for prevent itself from being included by
>> multiple times (an id used by itself -- like a handle), it is not an id
>> to let other files know about it (it is not a normal using way).
> 
> Whilst that *should* be true, it isn't actually true.  See:
> 
> 	grep -r _LINUX_.*_H /usr/include/ | grep -v ^/usr/include/linux/
> 
> for example.  Also who knows what all those autoconf scripts out there look
> for?
> 

Oh... the real world is really not quite perfect. :-/


> However, thinking about it some more, you're probably safe with respect to
> userspace as scripts/headers_install.h strips off the _UAPI prefix on the
> guard macros - just as long as you don't change the rest of the macro name.
> 

In honest, I really did not think more about it.

Only adding _UAPI (not touch others) can completely fix one style issue:
separate "uapi/*" from other sub-directories in "include/*"

So for me, we can continue improve this patch: add "_UAPI" for all guard
macro under "include/uapi/*" (also include "include/uapi/linux").


Thanks.
-- 
Chen Gang
