From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 3/3] Remove CONFIG_STRICT_DEVMEM
Date: Sun, 16 Nov 2008 15:46:57 +0000
Message-ID: <20081116154657.6629e6bf@lxorguk.ukuu.org.uk>
References: <1226846868-9595-1-git-send-email-bwalle@suse.de>
	<1226846868-9595-4-git-send-email-bwalle@suse.de>
	<20081116150901.4d824e6d@lxorguk.ukuu.org.uk>
	<20081116162149.07f05c7c@kopernikus.site>
Reply-To: "Discussion list for crash utility usage,
	maintenance and development" <crash-utility@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <crash-utility-bounces@redhat.com>
In-Reply-To: <20081116162149.07f05c7c@kopernikus.site>
List-Unsubscribe: <https://www.redhat.com/mailman/listinfo/crash-utility>,
	<mailto:crash-utility-request@redhat.com?subject=unsubscribe>
List-Archive: <https://www.redhat.com/archives/crash-utility>
List-Post: <mailto:crash-utility@redhat.com>
List-Help: <mailto:crash-utility-request@redhat.com?subject=help>
List-Subscribe: <https://www.redhat.com/mailman/listinfo/crash-utility>,
	<mailto:crash-utility-request@redhat.com?subject=subscribe>
Sender: crash-utility-bounces@redhat.com
Errors-To: crash-utility-bounces@redhat.com
To: Bernhard Walle <bwalle@suse.de>
Cc: linux-arch@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org, crash-utility@redhat.com
List-Id: linux-arch.vger.kernel.org

> if just that patch doesn't make it, well, ok for me. I just think
> CONFIG_STRICT_DEVMEM is superfluous when the runtime configuration
> option is present.

It should always be "N" because the only other option means "add
pointless code of no value whatsoever"

Which means strict_devmem really belongs in the bitbucket as a bad idea

Alan
