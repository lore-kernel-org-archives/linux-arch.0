From: Chen Gang <gang.chen@asianux.com>
Subject: Re: [PATCH trivial] include: uapi: standard all files' macro prefix
 and suffix, excluding "linux/" sub-directory
Date: Fri, 02 Aug 2013 16:31:59 +0800
Message-ID: <51FB6E7F.2050506@asianux.com>
References: <51FB6216.6010008@asianux.com> <51FB634F.5070401@asianux.com>
 <87iozoqzm9.fsf@tw-ebiederman.twitter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <87iozoqzm9.fsf@tw-ebiederman.twitter.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: xen-devel@lists.xensource.com, jeremy@goop.org, airlied@linux.ie, daniel.vetter@ffwll.ch, alsa-devel@alsa-project.org, dri-devel@lists.freedesktop.org, perex@perex.cz, "dhowells@redhat.com" <dhowells@redhat.com>, thierry.reding@gmail.com, linux-mtd@lists.infradead.org, sean.hefty@intel.com, virtualization@lists.linux-foundation.org, Linux-Arch <linux-arch@vger.kernel.org>, "kgene.kim@samsung.com" <kgene.kim@samsung.com>, tbergstrom@nvidia.com, jy0922.shim@samsung.com, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, roland@purestorage.com, Takashi Iwai <tiwai@suse.de>, Tomi Valkeinen <tomi.valkeinen@ti.com>, mtk.manpages@gmail.com, fcoe-devel@open-fcoe.org, Paul McKenney <paulmck@linux.vnet.ibm.com>, "plagnioj@jcrosoft.com" <plagnioj@jcrosoft.com>, Arnd Bergmann <arnd@arndb.de>, swarren@wwwdotorg.org, intel-gfx@lists.freedesktop.org, inki.dae@samsung.com, linux-samsung-
List-Id: linux-arch.vger.kernel.org

On 08/02/2013 04:13 PM, Eric W. Biederman wrote:
> Chen Gang <gang.chen@asianux.com> writes:
> 
>> It is a trivial patch for "include/uapi", exclude "linux" sub-directory.
>>
>> If it is useful, I will send another patch for "linux" sub-directory.
>>
>> BTW: it is really big mail addresses from
>> "./scripts/get_maintainers.pl"
> 
> What is the point?  Is there a bug that this fixes?
> 

It is a trivial patch, it is not for bug fix.

> These files are not used with api in their path in userspace so I
> suspect your change just makes things strange and confusing.
> 

Hmm... they are in "include/uapi" which means they may be shared with
user space, is it correct ? (or Universal API ? ... excuse me, I don't
know the definition of "include/uapi").

If some of them are really never shared with user space (or not
'Universal' enough to multiple OS), I recommend to move them from
"include/uapi/" to another more suitable places.


Thanks.

> Eric
> 
>> Thanks.
>>
>> On 08/02/2013 03:39 PM, Chen Gang wrote:
>>> For "include/uapi/*", excluding "linux/" sub-directory, let all files'
>>> macro prefix match the standard format, and give related stand comments
>>> for their macro suffix.
>>>
>>> The related standard format is:
>>>
>>>   "_SUBDIRNAME_SUBDIRNAME[_SUBDIRNAME]_FILENAME" (1st _SUBDIRNAME is _UAPI), and use '_' instead of '.' and '-'.
>>>
>>>
>>> Signed-off-by: Chen Gang <gang.chen@asianux.com>
>>> ---
>>>  include/uapi/asm-generic/auxvec.h      |    6 +++---
>>>  include/uapi/asm-generic/bitsperlong.h |    6 +++---
>>>  include/uapi/asm-generic/errno-base.h  |    6 +++---
>>>  include/uapi/asm-generic/errno.h       |    6 +++---
>>>  include/uapi/asm-generic/fcntl.h       |    6 +++---
>>>  include/uapi/asm-generic/ioctls.h      |    6 +++---
>>>  include/uapi/asm-generic/ipcbuf.h      |    6 +++---
>>>  include/uapi/asm-generic/kvm_para.h    |    5 +++++
>>>  include/uapi/asm-generic/mman-common.h |    6 +++---
>>>  include/uapi/asm-generic/mman.h        |    6 +++---
>>>  include/uapi/asm-generic/msgbuf.h      |    6 +++---
>>>  include/uapi/asm-generic/param.h       |    6 +++---
>>>  include/uapi/asm-generic/poll.h        |    6 +++---
>>>  include/uapi/asm-generic/posix_types.h |    6 +++---
>>>  include/uapi/asm-generic/sembuf.h      |    6 +++---
>>>  include/uapi/asm-generic/setup.h       |    6 +++---
>>>  include/uapi/asm-generic/shmbuf.h      |    6 +++---
>>>  include/uapi/asm-generic/shmparam.h    |    6 +++---
>>>  include/uapi/asm-generic/signal-defs.h |    6 +++---
>>>  include/uapi/asm-generic/signal.h      |    6 +++---
>>>  include/uapi/asm-generic/socket.h      |    6 +++---
>>>  include/uapi/asm-generic/sockios.h     |    6 +++---
>>>  include/uapi/asm-generic/stat.h        |    6 +++---
>>>  include/uapi/asm-generic/statfs.h      |    6 +++---
>>>  include/uapi/asm-generic/swab.h        |    6 +++---
>>>  include/uapi/asm-generic/termbits.h    |    6 +++---
>>>  include/uapi/asm-generic/types.h       |    6 +++---
>>>  include/uapi/asm-generic/ucontext.h    |    6 +++---
>>>  include/uapi/asm-generic/unistd.h      |    5 +++++
>>>  include/uapi/drm/drm.h                 |    6 +++---
>>>  include/uapi/drm/drm_fourcc.h          |    6 +++---
>>>  include/uapi/drm/drm_mode.h            |    6 +++---
>>>  include/uapi/drm/drm_sarea.h           |    6 +++---
>>>  include/uapi/drm/exynos_drm.h          |    6 +++---
>>>  include/uapi/drm/i810_drm.h            |    6 +++---
>>>  include/uapi/drm/i915_drm.h            |    6 +++---
>>>  include/uapi/drm/mga_drm.h             |    6 +++---
>>>  include/uapi/drm/nouveau_drm.h         |    6 +++---
>>>  include/uapi/drm/omap_drm.h            |    6 +++---
>>>  include/uapi/drm/qxl_drm.h             |    6 +++---
>>>  include/uapi/drm/r128_drm.h            |    6 +++---
>>>  include/uapi/drm/radeon_drm.h          |    6 +++---
>>>  include/uapi/drm/savage_drm.h          |    6 +++---
>>>  include/uapi/drm/sis_drm.h             |    6 +++---
>>>  include/uapi/drm/tegra_drm.h           |    6 +++---
>>>  include/uapi/drm/via_drm.h             |    6 +++---
>>>  include/uapi/drm/vmwgfx_drm.h          |    6 +++---
>>>  include/uapi/mtd/inftl-user.h          |    6 +++---
>>>  include/uapi/mtd/mtd-abi.h             |    6 +++---
>>>  include/uapi/mtd/mtd-user.h            |    6 +++---
>>>  include/uapi/mtd/nftl-user.h           |    6 +++---
>>>  include/uapi/mtd/ubi-user.h            |    6 +++---
>>>  include/uapi/rdma/ib_user_cm.h         |    6 +++---
>>>  include/uapi/rdma/ib_user_mad.h        |    6 +++---
>>>  include/uapi/rdma/ib_user_sa.h         |    6 +++---
>>>  include/uapi/rdma/ib_user_verbs.h      |    6 +++---
>>>  include/uapi/rdma/rdma_netlink.h       |    6 +++---
>>>  include/uapi/rdma/rdma_user_cm.h       |    6 +++---
>>>  include/uapi/scsi/fc/fc_els.h          |    6 +++---
>>>  include/uapi/scsi/fc/fc_fs.h           |    6 +++---
>>>  include/uapi/scsi/fc/fc_gs.h           |    6 +++---
>>>  include/uapi/scsi/fc/fc_ns.h           |    6 +++---
>>>  include/uapi/scsi/scsi_bsg_fc.h        |    7 +++----
>>>  include/uapi/scsi/scsi_netlink.h       |    7 +++----
>>>  include/uapi/scsi/scsi_netlink_fc.h    |    7 +++----
>>>  include/uapi/sound/asequencer.h        |    6 +++---
>>>  include/uapi/sound/asound.h            |    6 +++---
>>>  include/uapi/sound/asound_fm.h         |    6 +++---
>>>  include/uapi/sound/compress_offload.h  |    6 +++---
>>>  include/uapi/sound/compress_params.h   |    6 +++---
>>>  include/uapi/sound/emu10k1.h           |    6 +++---
>>>  include/uapi/sound/hdsp.h              |    6 +++---
>>>  include/uapi/sound/hdspm.h             |    6 +++---
>>>  include/uapi/sound/sb16_csp.h          |    6 +++---
>>>  include/uapi/sound/sfnt_info.h         |    6 +++---
>>>  include/uapi/video/edid.h              |    6 +++---
>>>  include/uapi/video/sisfb.h             |    6 +++---
>>>  include/uapi/video/uvesafb.h           |    6 +++---
>>>  include/uapi/xen/evtchn.h              |    6 +++---
>>>  include/uapi/xen/privcmd.h             |    6 +++---
>>>  80 files changed, 244 insertions(+), 237 deletions(-)
> 
> 


-- 
Chen Gang
