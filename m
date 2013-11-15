From: Jonas Bonn <jonas@southpole.se>
Subject: Re: [PATCH 13/17] openrisc: Refactor or32_early_setup()
Date: Fri, 15 Nov 2013 10:59:33 +0100
Message-ID: <5285F085.5060105@southpole.se>
References: <1384285347-13506-1-git-send-email-geert@linux-m68k.org>
	<1384285347-13506-14-git-send-email-geert@linux-m68k.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-bounces@lists.openrisc.net>
In-Reply-To: <1384285347-13506-14-git-send-email-geert@linux-m68k.org>
List-Unsubscribe: <http://lists.openrisc.net/options/linux>,
	<mailto:linux-request@lists.openrisc.net?subject=unsubscribe>
List-Archive: <http://lists.openrisc.net/pipermail/linux>
List-Post: <mailto:linux@lists.openrisc.net>
List-Help: <mailto:linux-request@lists.openrisc.net?subject=help>
List-Subscribe: <http://lists.openrisc.net/listinfo/linux>,
	<mailto:linux-request@lists.openrisc.net?subject=subscribe>
Sender: linux-bounces@lists.openrisc.net
Errors-To: linux-bounces@lists.openrisc.net
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-arch@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux@lists.openrisc.net
List-Id: linux-arch.vger.kernel.org

On 11/12/2013 08:42 PM, Geert Uytterhoeven wrote:
>    - Change fdt pointer (passed from head.S) from unsigned int to void *,
>      which allows to kill a cast, and makes it compatible with __dtb_start.
>    - Use pr_info(),
>    - Extract common part.
>
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Cc: Jonas Bonn <jonas@southpole.se>
> Cc: linux@lists.openrisc.net

Thanks, I'll take this one directly into the OpenRISC tree.

/Jonas
