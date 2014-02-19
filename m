From: Thomas Hellstrom <thellstrom@vmware.com>
Subject: Re: [PATCH 3/6] dma-buf: use reservation objects
Date: Wed, 19 Feb 2014 14:58:19 +0100
Message-ID: <5304B87B.6040804@vmware.com>
References: <20140217155056.20337.25254.stgit@patser>
	<20140217155617.20337.22601.stgit@patser>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20140217155617.20337.22601.stgit@patser>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/dri-devel>,
	<mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/dri-devel>,
	<mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: dri-devel-bounces@lists.freedesktop.org
Errors-To: dri-devel-bounces@lists.freedesktop.org
To: Maarten Lankhorst <maarten.lankhorst@canonical.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, ccross@google.com, linux-media@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On 02/17/2014 04:56 PM, Maarten Lankhorst wrote:
> This allows reservation objects to be used in dma-buf. it's required
> for implementing polling support on the fences that belong to a dma-buf.
>
> Signed-off-by: Maarten Lankhorst <maarten.lankhorst@canonical.com>
> Acked-by: Mauro Carvalho Chehab <m.chehab@samsung.com> #drivers/media/v4l2-core/

For the TTM part:

 Acked-by: Thomas Hellstrom <thellstrom@vmware.com>
