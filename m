From: Kalle Valo <kvalo@codeaurora.org>
Subject: Re: [PATCH v2 9/9] net: wireless: ath5k: Constify ioreadX() iomem
 argument (as in generic implementation)
Date: Fri, 10 Jan 2020 15:33:11 +0200
Message-ID: <87eew7sag8.fsf@codeaurora.org>
References: <20200108200528.4614-1-krzk@kernel.org>
 <20200108200528.4614-10-krzk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
In-Reply-To: <20200108200528.4614-10-krzk@kernel.org> (Krzysztof Kozlowski's
 message of "Wed, 8 Jan 2020 21:05:28 +0100")
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
> ---
>  drivers/net/wireless/ath/ath5k/ahb.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)

No need to have "net: wireless: " in the title, otherwise looks good.

Acked-by: Kalle Valo <kvalo@codeaurora.org>

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
