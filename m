From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v3 01/24] fix default __strnlen_user macro
Date: Wed, 28 Sep 2011 15:20:09 +0200
Message-ID: <201109281520.09981.arnd@arndb.de>
References: <1317155405-26235-1-git-send-email-msalter@redhat.com> <1317155405-26235-2-git-send-email-msalter@redhat.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1317155405-26235-2-git-send-email-msalter@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Salter <msalter@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Tuesday 27 September 2011, Mark Salter wrote:
> The existing __strnlen_user macro simply resolved to strnlen. However, the
> count returned by strnlen_user should include the NULL byte. This patch
> fixes the __strnlen_user macro to include the NULL byte in the count.
> 
> Signed-off-by: Mark Salter <msalter@redhat.com>

Acked-by: Arnd Bergmann <arnd@arndb.de>
