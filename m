From: David Howells <dhowells@redhat.com>
Subject: Re: [PATCH trivial] include: uapi: standard all files'
	macro prefix and suffix, excluding "linux/" sub-directory
Date: Mon, 04 Nov 2013 22:03:44 +0000
Message-ID: <11907.1383602624@warthog.procyon.org.uk>
References: <51FB6216.6010008@asianux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <intel-gfx-bounces@lists.freedesktop.org>
In-Reply-To: <51FB6216.6010008@asianux.com>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/intel-gfx>,
	<mailto:intel-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/intel-gfx>
List-Post: <mailto:intel-gfx@lists.freedesktop.org>
List-Help: <mailto:intel-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/intel-gfx>,
	<mailto:intel-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: intel-gfx-bounces@lists.freedesktop.org
Errors-To: intel-gfx-bounces@lists.freedesktop.org
To: Chen Gang <gang.chen@asianux.com>, 'Jiri Kosina' <trivial@kernel.org>
Cc: xen-devel@lists.xensource.com, jeremy@goop.org, airlied@linux.ie, daniel.vetter@ffwll.ch, alsa-devel@alsa-project.org, dri-devel@lists.freedesktop.org, perex@perex.cz, "dhowells@redhat.com" <dhowells@redhat.com>, thierry.reding@gmail.com, linux-mtd@lists.infradead.org, sean.hefty@intel.com, virtualization@lists.linux-foundation.org, Linux-Arch <linux-arch@vger.kernel.org>, "kgene.kim@samsung.com" <kgene.kim@samsung.com>, tbergstrom@nvidia.com, jy0922.shim@samsung.com, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, roland@purestorage.com, Takashi Iwai <tiwai@suse.de>, Tomi Valkeinen <tomi.valkeinen@ti.com>, mtk.manpages@gmail.com, fcoe-devel@open-fcoe.org, Paul McKenney <paulmck@linux.vnet.ibm.com>, "plagnioj@jcrosoft.com" <plagnioj@jcrosoft.com>, Arnd Bergmann <arnd@arndb.de>, swarren@wwwdotorg.org, intel-gfx@lists.freedesktop.org, inki.dae@samsung.com, linux-samsun
List-Id: linux-arch.vger.kernel.org

Chen Gang <gang.chen@asianux.com> wrote:

> For "include/uapi/*", excluding "linux/" sub-directory, let all files'
> macro prefix match the standard format, and give related stand comments
> for their macro suffix.
> 
> The related standard format is:
> 
>   "_SUBDIRNAME_SUBDIRNAME[_SUBDIRNAME]_FILENAME" (1st _SUBDIRNAME is _UAPI), and use '_' instead of '.' and '-'.

I strongly recommend _against_ this without very careful consideration.
Userspace sometimes depends on the name in the guard macro:-/

David
