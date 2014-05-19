From: John Stultz <john.stultz@linaro.org>
Subject: Re: [PATCH 4/6] android: convert sync to fence api, v5
Date: Mon, 19 May 2014 11:49:08 -0700
Message-ID: <CALAqxLWZvt3yF8kAQz1AnQMOv66qqN8jP_zQiPDpiDcVngAa0g@mail.gmail.com>
References: <20140224162607.20485.70967.stgit@patser>
 <20140224162951.20485.57579.stgit@patser>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20140224162951.20485.57579.stgit@patser>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Maarten Lankhorst <maarten.lankhorst@canonical.com>
Cc: linux-arch@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "linaro-mm-sig@lists.linaro.org" <linaro-mm-sig@lists.linaro.org>, Colin Cross <ccross@google.com>, linux-media@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Mon, Feb 24, 2014 at 8:29 AM, Maarten Lankhorst
<maarten.lankhorst@canonical.com> wrote:
> Just to show it's easy.
>
> Android syncpoints can be mapped to a timeline. This removes the need
> to maintain a separate api for synchronization. I've left the android
> trace events in place, but the core fence events should already be
> sufficient for debugging.
>
> v2:
> - Call fence_remove_callback in sync_fence_free if not all fences have fired.
> v3:
> - Merge Colin Cross' bugfixes, and the android fence merge optimization.
> v4:
> - Merge with the upstream fixes.
> v5:
> - Fix small style issues pointed out by Thomas Hellstrom.
>
> Signed-off-by: Maarten Lankhorst <maarten.lankhorst@canonical.com>

I ran this through a fairly simple unit test for the Android sw_sync
interface and it ran fine.  Also since Colin, Rom and Greg didn't seem
to have major objections last I spoke with them:

Acked-by: John Stultz <john.stultz@linaro.org>

thanks
-john
