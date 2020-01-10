From: Kalle Valo <kvalo@codeaurora.org>
Subject: Re: [PATCH v2 2/9] net: wireless: rtl818x: Constify ioreadX() iomem
 argument (as in generic implementation)
Date: Fri, 10 Jan 2020 15:32:13 +0200
Message-ID: <87imljsahu.fsf@codeaurora.org>
References: <20200108200528.4614-1-krzk@kernel.org>
 <20200108200528.4614-3-krzk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
In-Reply-To: <20200108200528.4614-3-krzk@kernel.org> (Krzysztof Kozlowski's
 message of "Wed, 8 Jan 2020 21:05:21 +0100")
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
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Rich Felker <dalias@libc.org>, Jiri Slaby <jirislaby@gmail.com>, Geert Uytterhoeven <geert+renesas@glider.be>, "Michael S. Tsirkin" <mst@redhat.com>, David Airlie <airlied@linux.ie>, Jason Wang <jasowang@redhat.com>, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org, "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, netdev@vger.kernel.org, Paul Mackerras <paulus@samba.org>, linux-arch@vger.kernel.org, Dave Jiang <dave.jiang@intel.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Helge Deller <deller@gmx.de>, linux-sh@vger.kernel.org, Alexey Brodkin <abrodkin@synopsys.com>, Ben Skeggs <bskeggs@redhat.com>, nouveau@lists.freedesktop.org, Dave Airlie <airlied@redhat.com>, Matt Turner <mattst88@gmail.com>, linux-snps-arc@lists.infradead.org, Nick Kossifidis <mickflemm@gmail.com>, Allen Hubbe <allenbh@gmail.com>, Arnd Bergmann <arnd@arn>
List-Id: linux-arch.vger.kernel.org

Krzysztof Kozlowski <krzk@kernel.org> writes:

> The ioreadX() helpers have inconsistent interface.  On some architectures
> void *__iomem address argument is a pointer to const, on some not.
>
> Implementations of ioreadX() do not modify the memory under the address
> so they can be converted to a "const" version for const-safety and
> consistency among architectures.
>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
>
> ---
>
> Changes since v1:
> 1. Add Geert's review.
> ---
>  drivers/net/wireless/realtek/rtl818x/rtl8180/rtl8180.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

No need to have "net: wireless: " in the title, this is enough.

rtl818x: Constify ioreadX() iomem argument (as in generic implementation)

I assume someone else will take this so here's my ack:

Acked-by: Kalle Valo <kvalo@codeaurora.org>

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
