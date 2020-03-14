From: Michael Kelley <mikelley@microsoft.com>
Subject: [PATCH v6 09/10] arm64: efi: Export screen_info
Date: Sat, 14 Mar 2020 08:35:18 -0700
Message-ID: <1584200119-18594-10-git-send-email-mikelley@microsoft.com>
References: <1584200119-18594-1-git-send-email-mikelley@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane-mx.org@lists.infradead.org>
In-Reply-To: <1584200119-18594-1-git-send-email-mikelley@microsoft.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane-mx.org@lists.infradead.org
To: will@kernel.org, ardb@kernel.org, arnd@arndb.de, catalin.marinas@arm.com, mark.rutland@arm.com, maz@kernel.org, linux-arm-kernel@lists.infradead.org, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org, linux-efi@vger.kernel.org, linux-arch@vger.kernel.org, olaf@aepfle.de, apw@canonical.com, vkuznets@redhat.com, jasowang@redhat.com, marcelo.cerri@canonical.com, kys@microsoft.com
Cc: sunilmut@microsoft.com, boqun.feng@gmail.com, mikelley@microsoft.com
List-Id: linux-arch.vger.kernel.org

The Hyper-V frame buffer driver may be built as a module, and
it needs access to screen_info. So export screen_info.

Signed-off-by: Michael Kelley <mikelley@microsoft.com>
---
 arch/arm64/kernel/efi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/kernel/efi.c b/arch/arm64/kernel/efi.c
index d0cf596..8ff557a 100644
--- a/arch/arm64/kernel/efi.c
+++ b/arch/arm64/kernel/efi.c
@@ -55,6 +55,7 @@ static __init pteval_t create_mapping_protection(efi_memory_desc_t *md)
 
 /* we will fill this structure from the stub, so don't put it in .bss */
 struct screen_info screen_info __section(.data);
+EXPORT_SYMBOL(screen_info);
 
 int __init efi_create_mapping(struct mm_struct *mm, efi_memory_desc_t *md)
 {
-- 
1.8.3.1
