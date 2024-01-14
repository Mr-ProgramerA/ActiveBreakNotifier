Add-Type -AssemblyName System.Windows.Forms

function Show-Prompt {
    $form = New-Object Windows.Forms.Form
    $form.Text = "Break Reminder"
    $form.Width = 300
    $form.Height = 150
    $form.FormBorderStyle = [System.Windows.Forms.FormBorderStyle]::FixedSingle

    $label = New-Object Windows.Forms.Label
    $label.Text = "Time for a break! Remember to drink water."
    $label.Location = New-Object System.Drawing.Point(10, 10)
    $label.AutoSize = $true

    $okButton = New-Object Windows.Forms.Button
    $okButton.Text = "OK"
    $okButton.Location = New-Object System.Drawing.Point(30, 70)
    $okButton.DialogResult = [System.Windows.Forms.DialogResult]::OK

    $snoozeButton = New-Object Windows.Forms.Button
    $snoozeButton.Text = "Snooze 5 min"
    $snoozeButton.Location = New-Object System.Drawing.Point(110, 70)
    $snoozeButton.Add_Click({ $form.Tag = "Snooze"; $form.Close() })

    $stopButton = New-Object Windows.Forms.Button
    $stopButton.Text = "Stop"
    $stopButton.Location = New-Object System.Drawing.Point(210, 70)
    $stopButton.DialogResult = [System.Windows.Forms.DialogResult]::Cancel

    $form.AcceptButton = $okButton
    $form.CancelButton = $stopButton

    $form.Controls.Add($label)
    $form.Controls.Add($okButton)
    $form.Controls.Add($snoozeButton)
    $form.Controls.Add($stopButton)

    $result = $form.ShowDialog()

    $form.Dispose()

    return $result, $form.Tag
}

while ($true) {
    $result, $action = Show-Prompt

    switch ($result) {
        "OK" {
            # Continue with the script or schedule the next reminder after 45 minutes
            Start-Sleep -Seconds 2700
        }
        "Cancel" {
            if ($action -eq "Snooze") {
                Start-Sleep -Seconds 300  # Snooze for 5 minutes
            } else {
                exit  # Stop the script or exit
            }
        }
    }
}
